require 'cgi'
require 'base64'
require 'openssl'

class Api::PlayersController < ApplicationController
  def index
    if to_boolean(params['addSettingOn']) && to_boolean(params['percentageSettingOn'])
      @players = Player.where("percent_owned < ? AND (net_adds > ? OR percent_owned_change > ?)", params['ownershipMaxPercentage'], params['addsNum'], params['percentageNum']).order('percent_owned_change DESC, net_adds DESC');
    elsif to_boolean(params['addSettingOn'])
      @players = Player.where("percent_owned < ? AND net_adds > ?", params['ownershipMaxPercentage'], params['addsNum']).order('percent_owned_change DESC, net_adds DESC');
    elsif to_boolean(params['percentageSettingOn'])
      @players = Player.where("percent_owned < ? AND percent_owned_change > ?", params['ownershipMaxPercentage'], params['percentageNum']).order('percent_owned_change DESC, net_adds DESC');
    else
      @players = []
    end
  end

  def to_boolean(str)
    str == "true"
  end


  @@access_token = nil
  @@request_token = nil
  def get_request_token
      @@consumer = OAuth::Consumer.new('dj0yJmk9NUdEMjc5ZjlDQWxwJmQ9WVdrOWFtOWxTazVyTnpnbWNHbzlNQS0tJnM9Y29uc3VtZXJzZWNyZXQmeD00YQ--',
          '1b08f62f2b8cc1d3bad3acf1ec90f2caa3aff8dd',
          {
            :site                 => 'https://api.login.yahoo.com',
            :scheme               => :query_string,
            :http_method          => :get,
            :request_token_path   => '/oauth/v2/get_request_token',
            :access_token_path    => '/oauth/v2/get_token',
            :authorize_path       => '/oauth/v2/request_auth'
          })
      @@request_token = @@consumer.get_request_token( { :oauth_callback => 'http://localhost:3000/callback' } )
      session[:request_token]=@@request_token
      redirect_to @@request_token.authorize_url
  end


  def callback
      request_token = ActiveSupport::JSON.decode(@@request_token.to_json)

      if !(request_token.present?)
        $request_token_value = "Response failed"
      else
        $request_token_value = request_token
      end
      @@access_token =    @@request_token.get_access_token(:oauth_verifier=>params[:oauth_verifier])
      access_json = ActiveSupport::JSON.decode(@@access_token.to_json)
      puts "****************************"
      puts $access_json
      puts "****************************"



      oauth_consumer_key = access_json["consumer"]["key"]
      oauth_nonce = Random.rand(100000).to_s
      oauth_signature_method = 'HMAC-SHA1'
      oauth_timestamp = Time.now.to_i.to_s
      oauth_version = '1.0'
      oauth_token = access_json["params"]["oauth_token"]

      url =  'http://fantasysports.yahooapis.com/fantasy/v2/player/'

      parameters = 'oauth_consumer_key=' +
              oauth_consumer_key +
              '&oauth_nonce=' +
              oauth_nonce +
              '&oauth_signature_method=' +
              oauth_signature_method +
              '&oauth_timestamp=' +
              oauth_timestamp +
              '&oauth_token=' +
              oauth_token +
              '&oauth_version=' +
              oauth_version

      base_string = 'GET&' + CGI.escape(url) + '&' + CGI.escape(parameters)

      ## Cryptographic hash function used to generate oauth_signature
      # by passing the secret key and base string. Note that & has
      # been appended to the secret key. Don't forget this!
      #
      # This line of code is from a SO topic
      # (http://stackoverflow.com/questions/4084979/ruby-way-to-generate-a-hmac-sha1-signature-for-oauth)
      # with minor modifications.
      secret_key = access_json["params"]["oauth_token_secret"] # Dummy shared secret, change to yours
      oauth_signature = CGI.escape(Base64.encode64("#{OpenSSL::HMAC.digest('sha1',secret_key, base_string)}").chomp)
      testable_url = url + '?' + parameters + '&oauth_signature=' + oauth_signature
      byebug
  end
end
