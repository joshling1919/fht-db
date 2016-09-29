# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'open-uri'
require 'json'
response = open('http://api.fantasy.nfl.com/players/researchinfo?format=json&count=1000').read
response = JSON.parse(response)

UpdateLog.create!(time: response["lastUpdated"])

response["players"].each do |player|
  percentOwned = player["percentOwned"] ? player["percentOwned"].to_f : 0.0

  percentOwnedChange = player["percentOwnedChange"] ? player["percentOwnedChange"].to_f : 0.0

  percentStarted = player["percentStarted"] ? player["percentStarted"].to_f : 0.0

  percentStartedChange = player["percentStartedChange"] ? player["percentStartedChange"].to_f : 0.0

  depthChartOrder = player["depthChartOrder"] ? player["depthChartOrder"].to_i : 0
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
