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
      existing_player = Player.find_by(nflId: player["id"].to_i)

      if existing_player
        existing_player.update!(
          opponentTeamAbbr: player["opponentTeamAbbr"],
          percentOwned: percentOwned,
          percentOwnedChange: percentOwnedChange,
          percentStarted: percentStarted,
          percentStartedChange: percentStartedChange,
          depthChartOrder: depthChartOrder,
          numAdds: player["numAdds"].to_i,
          numDrops: player["numDrops"].to_i,
          netAdds: (player["numAdds"].to_i - player["numDrops"].to_i)
        )
      else
        Player.create!(
            nflId: player["id"].to_i,
            firstName: player["firstName"],
            lastName: player["lastName"],
            teamAbbr: player["teamAbbr"],
            opponentTeamAbbr: player["opponentTeamAbbr"],
            position: player["position"],
            percentOwned: percentOwned,
            percentOwnedChange: percentOwnedChange,
            percentStarted: percentStarted,
            percentStartedChange: percentStartedChange,
            depthChartOrder: depthChartOrder,
            numAdds: player["numAdds"].to_i,
            numDrops: player["numDrops"].to_i,
            netAdds: (player["numAdds"].to_i - player["numDrops"].to_i)
          )
        end
      end
  end

end
