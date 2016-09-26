class AddIdColumn < ActiveRecord::Migration
  def change
    add_column :players, :espnId, :integer
    add_column :players, :netAdds, :integer
    add_index :players, :espnId
    add_index :players, :percentOwnedChange
    add_index :players, :netAdds
  end
end
