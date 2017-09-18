FactoryGirl.define do
  factory :user_config_bsas, class: UserConfig do
    start_time 11.0
    end_time 1.0
    time_zone "Buenos Aires"
    times 2
  end
  
  factory :user_config_jerusalem, class: UserConfig do
    start_time 6.0
    end_time 20.0
    time_zone "Jerusalem"
    times 2
  end
end
