class RemoveCreatedAtFromSurveys < ActiveRecord::Migration[5.1]
  def change
    remove_column :surveys, :created_at
    add_column :surveys, :created, :datetime,  default: -> { 'CURRENT_TIMESTAMP' }
  end
end
