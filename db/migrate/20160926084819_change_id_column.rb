class ChangeIdColumn < ActiveRecord::Migration
  def change
    remove_column :players, :espnId, :integer
    add_column :players, :nflId, :integer
    add_index :players, :nflId
  end
end
