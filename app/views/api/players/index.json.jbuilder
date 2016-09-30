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
  # json.extract!(player, :nfl_id, :first_name, :last_name, :team_abbr,
  # :opponent_team_abbr, :position, :percent_owned, :percent_owned_change,
  # :percent_started, :percent_started_change, :num_adds, :num_drops, :net_adds)
end
