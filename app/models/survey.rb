class Survey < ApplicationRecord
    #presence
    validates :feeling, :focus, :activity_id, :user_id, presence: true
    
    #Numericality
    validates :feeling, numericality: { only_integer: true, greater_than: 0, less_than: 100  }
    validates :focus, numericality: { only_integer: true, greater_than: 0, less_than: 100  }

    #Associations
    belongs_to :user
    belongs_to :activity
    
    #Callbacks
    before_save { if (self.created.nil?) 
                    self.created = DateTime.now 
                end
    }
    
end
