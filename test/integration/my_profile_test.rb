require 'test_helper'

class MyProfileTest < ActionDispatch::IntegrationTest
  include FactoryGirl::Syntax::Methods
  include SessionsHelper
  
  def setup
    @user = create(:user)
    post login_path, params: { session: { email: @user.email, password: @user.password } }
  end
  
  test 'get user show if logged in' do
    get profile_path
    assert_template 'users/show'
  end
  
  test 'get login screen if no' do
    delete logout_path
    
    get profile_path
    assert_redirected_to login_path
  end
    
  
  
end
