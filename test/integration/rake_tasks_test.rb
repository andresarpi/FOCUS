require 'test_helper'

class RakeTasksTest < ActionDispatch::IntegrationTest
  include FactoryGirl::Syntax::Methods

  def setup
    Rails.application.load_tasks
    @user = create(:user)
    @config = build(:user_config_bsas)
    @config.user_id = @user.id
    @config.save

    @user_survey_chedule = UserSurveySchedule.create(user_id: @user.id, scheduled_time: get_float_now)

  end

  ###########     Survey_scheduling       ##############################
  test 'generate UserSurveySchedule with clean up' do
    Rake::Task['survey_scheduling:generate_schedule_with_clean_up'].invoke
    count = UserSurveySchedule.count
    assert count == @user.config.times  
  end

  
  test 'clean up existing UserSurveySchedules' do
    Rake::Task['survey_scheduling:clean_up'].invoke
    count = UserSurveySchedule.count
    assert count == 0
  end

  ######## Survey_sending ############
  test 'the survey sender is actually sending emails' do  
    assert_output(/There were/) { Rake::Task['survey_sending:send_survey'].invoke }
  end

  test "if there are no emails being sent then there shoud be no emails being sent" do
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
