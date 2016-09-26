# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'open-uri'
require 'byebug'
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
