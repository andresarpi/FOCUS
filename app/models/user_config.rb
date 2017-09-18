class UserConfig < ApplicationRecord
    belongs_to :user
    
    validates :times, :start_time, :end_time, :time_zone, presence: true

    validates :start_time , numericality: { greater_than: 0, less_than: 24  }
    validates :end_time , numericality: { greater_than: 0, less_than: 24  }
    validates :times, numericality: {greater_than: 0, less_than: 24}

    validate :start_time, :start_time_cant_be_equal_to_end_time

    def start_time_cant_be_equal_to_end_time
        if start_time == end_time
            errors.add(:start_end_time, "Start and end time can't be equal")
        end
    end
    
    def local_start_time(floatTime)
        if (!param_between_0_24?(floatTime)) 
            raise ArgumentError.new("Parameter should be between 0 and 24")
        end

        Time.zone = self.time_zone
        self.start_time = floatTime - Time.zone.utc_offset/3600
        if (self.start_time <= 0)
            self.start_time = 24 + self.start_time
        end   
    end
    
    def local_end_time(floatTime)
        if (!param_between_0_24?(floatTime)) 
            raise ArgumentError.new("Parameter should be between 0 and 24")
        end

        Time.zone = self.time_zone
        self.end_time = floatTime - Time.zone.utc_offset/3600
        if (self.end_time >= 24)
            self.end_time = self.end_time - 24
        end
    end

    private 
        def param_between_0_24?(param)
            if ( (param < 0) || (param >= 24) )
                false
            else
                true
            end
        end
end
