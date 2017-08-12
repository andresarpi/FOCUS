require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  include FactoryGirl::Syntax::Methods
  include SessionsHelper
  
  def setup
    @user = create(:user)
  end
  
  
  test 'template rendering' do
    get login_path
    assert_template 'sessions/new'
  end
  
  
  test 'log in with valid information' do
    
    post login_path, params: { session: { email: @user.email, password: @user.password } }
    assert is_logged_in? 
  end
  
  
  test "login with invalid information" do
      
    post login_path, params: { session: { email: "", password: "" } }
    assert_template 'sessions/new'
    assert_not flash.empty?
    
    get login_path
    assert flash.empty?
  end
  
  
  test 'logout' do
    
    post login_path, params: { session: { email: @user.email, password: @user.password } }
    assert is_logged_in?
    
    delete logout_path
    assert_not is_logged_in?
  end
  
end