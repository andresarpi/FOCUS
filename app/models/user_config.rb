class UserConfig < ApplicationRecord
    belongs_to :user
    
    validates :start_time, :end_time, :time_zone, presence: true

    validates :start_time , numericality: { greater_than: 0, less_than: 100  }
    validates :end_time , numericality: { greater_than: 0, less_than: 100  }
    
    def local_start_time(floatTime)
        Time.zone = self.time_zone
        self.start_time = floatTime - Time.zone.utc_offset/3600
        if (self.start_time <= 0)
            self.start_time = 24 + self.start_time
        end
        
    end
    
    def local_end_time(floatTime)
        Time.zone = self.time_zone
        self.end_time = floatTime - Time.zone.utc_offset/3600
        if (self.end_time >= 24)
            self.end_time = self.end_time - 24
        end
    end
end
