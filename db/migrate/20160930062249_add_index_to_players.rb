class AddIndexToPlayers < ActiveRecord::Migration
  def change
    add_index :players, :percent_owned
  end
end
