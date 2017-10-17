namespace :survey_sending do
  desc "Send a email to users telling them of their survey"
  task send_survey: :environment do
    sv = SurveySender.new
    if  sv.send_emails 
      puts "There were emails sent"
    end
  end


end
