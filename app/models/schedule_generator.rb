class ScheduleGenerator
	@@schedule_factory

	def self.clean_up
		UserSurveySchedule.delete_all
	end

	def self.generate_schedule
		users = get_users
		values_string = ""

		users.each  do |u|
			intervals = calculate_intervals(u)
			scheduled_times = calculate_scheduled_times(intervals)
			clean_scheduled_times = clean_up_scheduled_times(scheduled_times)

			values_string += clean_scheduled_times.map {|st| "(#{u.id}, #{st})"}.join(", ")
			values_string += ", "
		end

		values_string = values_string[0..-3]
		
		ActiveRecord::Base.connection.execute("INSERT INTO user_survey_schedules (user_id, scheduled_time) VALUES #{values_string}")
	end

	def self.calculate_intervals(user)
		intervals = []
		my_start_time = user.config.start_time
		if (user.config.start_time < user.config.end_time)
			my_end_time = user.config.end_time
		else
			my_end_time = 24 + user.config.end_time	
		end
		inter = (my_end_time - my_start_time) / user.config.times
		user.config.times.times do |x|
			interval_start = my_start_time + (inter * x)
			interval_end = my_start_time + (inter * (x + 1) )
			interval = [clean_up_number(interval_start), clean_up_number(interval_end)]
			intervals.push(interval)
		end
		return intervals
	end

	def self.clean_up_number(n)
		n = (n * 2).floor / 2.0
		return n
	end

	def self.calculate_scheduled_times(intervals)
		scheduled_times = []
		intervals.each do |interval|
			result = interval[0] + (Random.rand(interval[1] - interval[0]).floor+ 1.0 ) / 2.0
			scheduled_times.push(result) 
		end
		return scheduled_times
	end

	def self.clean_up_scheduled_times(scheduled_times)
		##This method needs refratoring and the tests too. Right now its correcting
		#for schedules of > 24, AND removing those between 0 and 1. The best solution might be
		#to remove those two ops to diferent methods
		clean_scheduled_times = []
		scheduled_times.each do |time|
			if (time > 24)
				time = time - 24
			end
			
			if (time >= 1)
				clean_scheduled_times.push(time)
			end
		end
		return clean_scheduled_times
	end

	def self.get_users
		users = User.joins(:config)
				.select("users.id, user_configs.start_time, user_configs.end_time, user_configs.times")
		if users.empty?
			raise Exceptions::NoUsersWithValidConfigError, "There were no users with a vaid config"
		else
			return users
		end
	end

	def self.assign_factory(user)
		if (user.start_time < user.end_time)
			NormalScheduleFactory.new
		else
			InverseScheduleFactory.new
		end
	end

	private_class_method :get_users, :assign_factory


end