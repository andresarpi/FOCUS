require 'test_helper'

class ScheduleGeneratorTest < ActiveSupport::TestCase
	include FactoryGirl::Syntax::Methods
	def setup 
		@userBsAs = create(:user)
		@configBsAs = build(:user_config_bsas)
		@configBsAs.user_id = @userBsAs.id
		@configBsAs.save

		@userJerusalem = create(:userbis)
		@configJerusalem = build(:user_config_jerusalem)
		@configJerusalem.user_id = @userJerusalem.id
		@configJerusalem.save
	end	

	test 'generate schedule for jerusalem' do
		intervals = ScheduleGenerator.calculate_intervals(@userJerusalem)
		desired_interval = [[6,13],[13,20]]
		assert(intervals == desired_interval)
	end

	test 'generate schedule for buenos aires' do
		intervals = ScheduleGenerator.calculate_intervals(@userBsAs)
		desired_interval = [[11,18],[18,25]]
		assert(intervals == desired_interval)
	end

	test 'generated sheduled time' do
		intervals = ScheduleGenerator.calculate_intervals(@userBsAs)
		scheduled_times = ScheduleGenerator.calculate_scheduled_times(intervals)
		intervals.each_with_index do |interval, index|
			assert(interval[0] < scheduled_times[index])
			assert(interval[1] > scheduled_times[index])
		end
	end

	test 'test the cleaning up method' do
		scheduled_times = [0.5, 12.0, 19.0, 24.5]
		clean_scheduled_times = ScheduleGenerator.clean_up_scheduled_times(scheduled_times)
		clean_scheduled_times.each do |time|
			assert time >= 1
			assert time < 24
		end 
	end

	test 'properly test the schedule generator' do
		ScheduleGenerator.generate_schedule
		assert(@userJerusalem.scheduled_surveys.count <= @userJerusalem.config.times)
		assert(@userJerusalem.scheduled_surveys.count > 0)
	end

	test 'clean up scheduled surveys' do
		ScheduleGenerator.clean_up
		assert(UserSurveySchedule.count == 0)
	end



end
