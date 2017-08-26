class UserSurveySchedule < ApplicationRecord
    belongs_to :user

    validates :user_id, :scheduled_time, presence: true
    validates :scheduled_time, numericality: {less_than: 24, greater_than_or_equal_to: 1}
end
