namespace :survey_sending do
  desc "Send a email to users telling them of their survey"
  task send_survey: :environment do
    sv = SurveySender.new
    sv.send_emails
  end

  desc "Send a dummy email to test the email capabilities"
  task send_email: :environment do

  end

end
