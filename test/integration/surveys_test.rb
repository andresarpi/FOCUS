
require 'test_helper'

class SurveysTest < ActionDispatch::IntegrationTest
  include FactoryGirl::Syntax::Methods
  include SessionsHelper
  
  def setup
    @user = create(:user)
    @activity = create(:activity)
    
    post login_path, params: { session: { email: @user.email, password: @user.password } }
  end
  
  test 'redirects to login and redirects back' do
    delete logout_path

    get new_user_survey_path(@user) #"/users/#{@user.id}/surveys/new"
    assert_redirected_to login_path
    
    post login_path, params: { session: { email: @user.email, password: @user.password } }
    assert_redirected_to new_user_survey_path(@user)
  end
  
  test 'shows correct template when logged in' do
    get new_user_survey_path(@user)
    assert_template 'surveys/new'
  end
  
  test 'post survey with valid information' do
    surveyCount = Survey.count
    post user_surveys_path(@user), params: { survey: { feeling: 50, focus: 50, activity_id: @activity.id } }
    assert(surveyCount + 1 == Survey.count)
  end
  
  
  test "post survey with invalid information" do
    assert_no_difference 'Survey.count' do
      post user_surveys_path(@user), params: { survey: { feeling: 0, focus: 50, activity_id: @activity.id } }
    end
    assert_not(flash.empty?)
  end
  
end
