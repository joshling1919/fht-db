json.array! @players do |player|
  json.nflId player.nfl_id
  json.firstName player.first_name
  json.lastName player.last_name
  json.teamAbbr player.team_abbr
  json.opponentTeamAbbr player.opponent_team_abbr
  json.position player.position
  json.percentOwned player.percent_owned
  json.percentOwnedChange player[:percent_owned_change]
  json.percentStarted player.percent_started
  json.percentStartedChange player[:percent_started_change]
  json.numAdds player.num_adds
  json.numDrops player.num_drops
  json.netAdds player.net_adds
end
