require 'open-uri'
require 'json'

namespace :update_players do
  desc "updates players with ownership change percentages"
  task ownership: :environment do
    response = open('http://api.fantasy.nfl.com/players/researchinfo?count=1000&format=json&sort=percentOwnedDelta').read
    response = JSON.parse(response)

    UpdateLog.create!(time: response["lastUpdated"])
    puts 'updating ownership changes'
    puts "updating with info from #{response["lastUpdated"]}"
    puts "updated at #{Time.now}"

    response["players"].each do |player|
      percentOwned = player["percentOwned"] ? player["percentOwned"].to_f : 0.0

      percentOwnedChange = player["percentOwnedChange"] ? player["percentOwnedChange"].to_f : 0.0

      percentStarted = player["percentStarted"] ? player["percentStarted"].to_f : 0.0

      percentStartedChange = player["percentStartedChange"] ? player["percentStartedChange"].to_f : 0.0

      depthChartOrder = player["depthChartOrder"] ? player["depthChartOrder"].to_i : 0
      existing_player = Player.find_by(nfl_id: player["id"].to_i)

      if existing_player
        existing_player.update!(
          opponent_team_abbr: player["opponentTeamAbbr"],
          percent_owned: percentOwned,
          percent_owned_change: percentOwnedChange,
          percent_started: percentStarted,
          percent_started_change: percentStartedChange,
          depth_chart_order: depthChartOrder,
          num_adds: player["numAdds"].to_i,
          num_drops: player["numDrops"].to_i,
          net_adds: (player["numAdds"].to_i - player["numDrops"].to_i)
        )
      else
        Player.create!(
            nfl_id: player["id"].to_i,
            first_name: player["firstName"],
            last_name: player["lastName"],
            team_abbr: player["teamAbbr"],
            opponent_team_abbr: player["opponentTeamAbbr"],
            position: player["position"],
            percent_owned: percentOwned,
            percent_owned_change: percentOwnedChange,
            percent_started: percentStarted,
            percent_started_change: percentStartedChange,
            depth_chart_order: depthChartOrder,
            num_adds: player["numAdds"].to_i,
            num_drops: player["numDrops"].to_i,
            net_adds: (player["numAdds"].to_i - player["numDrops"].to_i)
          )
        end
      end
  end

end
