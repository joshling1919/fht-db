class Api::PlayersController < ApplicationController
  def index
    if to_boolean(params['addSettingOn']) && to_boolean(params['percentageSettingOn'])
      @players = Player.where("percent_owned < ? AND (net_adds > ? OR percent_owned_change > ?)", 50, params['addsNum'], params['percentageNum']).limit(10).order('percent_owned_change DESC, net_adds DESC');
    elsif to_boolean(params['addSettingOn'])
      @players = Player.where("percent_owned < ? AND net_adds > ?", 50, params['addsNum']).limit(10).order('percent_owned_change DESC, net_adds DESC');
    elsif to_boolean(params['percentageSettingOn'])
      @players = Player.where("percent_owned < ? AND percent_owned_change > ?", 50, params['percentageNum']).limit(10).order('percent_owned_change DESC, net_adds DESC');
    else
      @players = []
    end

  end

  def to_boolean(str)
    str == "true"
  end
end
