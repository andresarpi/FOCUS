require 'test_helper'

class UserSurveyScheduleTest < ActiveSupport::TestCase
  include FactoryGirl::Syntax::Methods
  
  def setup 
    @user = create(:user)#User.new(name: "Andres Arpi", email: "aarpi@itba.edu.ar", password: "123456"
    @UserSurveySchedule = UserSurveySchedule.new
    @UserSurveySchedule.user_id = @user.id
    @UserSurveySchedule.scheduled_time = 22.5
  end

  test 'should be valid' do
    assert(@UserSurveySchedule.valid?)
  end

  test 'should have user' do
    assert(@UserSurveySchedule.user.name =  @user.name)
  end

  test 'scheduled time should be between 1 and <24'  do
    @UserSurveySchedule.scheduled_time = 24
    assert_not(@UserSurveySchedule.valid?)

    @UserSurveySchedule.scheduled_time = 0.5
    assert_not(@UserSurveySchedule.valid?)
  end

end
