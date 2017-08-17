
require 'test_helper'

class SurveysTest < ActionDispatch::IntegrationTest
  include FactoryGirl::Syntax::Methods
  include SessionsHelper
  
  def setup
    @user = create(:user)
    delete logout_path
  end
  
  test 'redirects to login and redirects back' do
    get new_survey_path
    assert_redirected_to login_path
    
    post login_path, params: { session: { email: @user.email, password: @user.password } }
    assert_redirected_to new_survey_path
  end
  
  test 'shows correct template when logged in' do
    log_in(@user)
    
    get new_survey_path
  end
  
end
