class FixColumnName < ActiveRecord::Migration
  def change
    rename_column :players, :gsisPlayerId, :gsis_player_id
    rename_column :players, :firstName, :first_name
    rename_column :players, :lastName, :last_name
    rename_column :players, :teamAbbr, :team_abbr
    rename_column :players, :opponentTeamAbbr, :opponent_team_abbr
    rename_column :players, :percentOwned, :percent_owned
    rename_column :players, :percentOwnedChange, :percent_owned_change
    rename_column :players, :percentStarted, :percent_started
    rename_column :players, :percentStartedChange, :percent_started_change
    rename_column :players, :depthChartOrder, :depth_chart_order
    rename_column :players, :numAdds, :num_adds
    rename_column :players, :numDrops, :num_drops
    rename_column :players, :netAdds, :net_adds
    rename_column :players, :nflId, :nfl_id
  end
end
