FactoryGirl.define do
  factory :user_config_bsas, class: UserConfig do
    start_time 1
    end_time 22.5
    time_zone "Buenos Aires"
  end
  
  factory :user_config_jerusalem, class: UserConfig do
    start_time 1
    end_time 22.5
    time_zone "Jerusalem"
  end
end
