class CreateUserConfigs < ActiveRecord::Migration[5.1]
  def change
    create_table :user_configs do |t|

      t.timestamps
    end
  end
end
