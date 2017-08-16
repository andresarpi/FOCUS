class Activity < ApplicationRecord
    has_many :surveys
        validates :name, presence: true
end
