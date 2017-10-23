namespace :survey_scheduling do
  desc "Execute the schedule generator cleaning up first"
  task generate_schedule_with_clean_up: :environment do
    ScheduleGenerator.clean_up
    ScheduleGenerator.generate_schedule
  end

  desc "Execute the schedule generator without cleaning up first"
  task generate_schedule_without_clean_up: :environment do
    ScheduleGenerator.generate_schedule
  end

  desc "Clean up the user_survey_shedule table"
  task clean_up: :environment do
    ScheduleGenerator.clean_up
  end
end
