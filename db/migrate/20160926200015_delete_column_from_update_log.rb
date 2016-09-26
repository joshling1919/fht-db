class DeleteColumnFromUpdateLog < ActiveRecord::Migration
  def change
    remove_column :update_logs, :current_datetime, :datetime
  end
end
