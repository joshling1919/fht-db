class AddCurrentTime < ActiveRecord::Migration
  def change
    add_column :update_logs, :current_datetime, :datetime
  end
end
