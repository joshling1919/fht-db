class Api::PlayersController < ApplicationController
  def index
    if to_boolean(params['addSettingOn']) && to_boolean(params['percentageSettingOn'])
      # @players = Player.where("netAdds > #{params['addsNum']} OR  ").limit(100)
    elsif to_boolean(params['addSettingOn'])

    elsif to_boolean(params['percentageSettingOn'])

    else
      @players = []
    end

  end

  def to_boolean(str)
    str == "true"
  end
end
