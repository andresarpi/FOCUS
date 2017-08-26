class CreateUserSurveySchedules < ActiveRecord::Migration[5.1]
  def change
    create_table :user_survey_schedules do |t|
      t.integer :user_id
      t.float :scheduled_time

    end
    add_column :user_configs, :times, :integer
    add_foreign_key :user_survey_schedules, :user, on_delete: :cascade
    add_index :user_survey_schedules, :user_id
  end
end
