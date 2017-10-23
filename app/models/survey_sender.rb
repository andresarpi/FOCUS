class SurveySender
    attr_reader :float_now
    def initialize
        @float_now = get_float_now
    end

    def send_emails
        float_now = get_float_now

        paywall = {}
        paywall[:from] = "Mailgun Sandbox <postmaster@sandbox18e52f1d8d9c488384badd2bb939e5a4.mailgun.org>"
        paywall[:subject] = "Time for a FOCUS survey, %recipient.name%"
        paywall[:text] = "Hi %recipient.name%, \n Please go to https://focus.com/surveys/new and complete your survey."
        
        users_found = false

        UserSurveySchedule.joins(:user)
                        .where(scheduled_time: float_now)
                        .select("user_survey_schedules.id, user_survey_schedules.user_id, users.name, users.email")
                        .find_in_batches(batch_size: 100) do |users|
                            users_found = true
                            send_batch_survey_mail(users, paywall)
                        end

        if users_found
            return true
        else
            return false
        end
    end

    def send_batch_survey_mail(users, paywall)
        paywall[:to] = ""
        recipient_variables = {}
        users.each do |user|
            paywall[:to] << "#{user.email}, "
            recipient_variable = {}
            recipient_variable[:name] = user.name
            recipient_variables[user.email] = recipient_variable
        end
        paywall[:to] = paywall[:to][0..-3]
        paywall[:'recipient-variables'] = recipient_variables.to_json
        MailgunClient.new.send_mail(paywall)

    end

    private
    def get_float_now
        t = Time.current
        minutes = t.min
        if (minutes < 30)
            minutes = 0.0
        else
            minutes = 0.5
        end
        return t.hour+minutes
    end
end
