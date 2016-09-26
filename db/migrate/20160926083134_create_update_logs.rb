class CreateUpdateLogs < ActiveRecord::Migration
  def change
    create_table :update_logs do |t|
      t.string :time
      t.timestamps null: false
    end
  end
end
