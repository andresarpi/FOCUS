class AddColumnsToUserConfig < ActiveRecord::Migration[5.1]
  def change
    add_column :user_configs, :user_id, :integer
    add_column :user_configs, :start_time, :float
    add_column :user_configs, :end_time, :float
    add_column :user_configs, :time_zone, :string
    
    add_foreign_key :user_configs, :user, on_delete: :cascade
    add_index :user_configs, :user_id, unique: true
  end
end
