class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :esbid
      t.string :gsisPlayerId
      t.string :firstName
      t.string :lastName
      t.string :teamAbbr
      t.string :opponentTeamAbbr
      t.string :position
      t.float :percentOwned
      t.float :percentOwnedChange
      t.float :percentStarted
      t.float :percentStartedChange
      t.integer :depthChartOrder
      t.integer :numAdds
      t.integer :numDrops
      t.timestamps null: false
    end
  end
end
