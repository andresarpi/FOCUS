class Survey < ApplicationRecord
    #presence
    validates :feeling, :focus, :activity_id, :user_id, presence: true
    
    validates :feeling, numericality: { only_integer: true, greater_than: 0, less_than: 100  }
    validates :focus, numericality: { only_integer: true, greater_than: 0, less_than: 100  }

    
    before_save { self.created_at = DateTime.now }
    
end
