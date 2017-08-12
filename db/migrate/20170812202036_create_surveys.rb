class CreateSurveys < ActiveRecord::Migration[5.1]
  def change
    create_table :surveys do |t|
      t.references :user
      t.datetime :created_at
      t.integer :feeling
      t.integer :focus
      t.integer :activity_id
    end
  end
end
