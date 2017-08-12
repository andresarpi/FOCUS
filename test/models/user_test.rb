require 'test_helper'

class UserTest < ActiveSupport::TestCase
  include FactoryGirl::Syntax::Methods
  
  def setup 
    @user = build(:user) #User.new(name: "Andres Arpi", email: "aarpi@itba.edu.ar", password: "123456"
    @passwordlessUser = build(:passwordlessUser)
  end
  
  test 'should be valid?' do
    assert @user.valid?
  end
  
  ##Presence
    test 'name should be present' do
      @user.name = ""
      assert_not @user.valid?
    end
    
    test 'email should be present' do
      @user.email = ""
      assert_not @user.valid?
    end
    
    test 'password should be present' do
      assert_not @passwordlessUser.valid?
    end
    
  #Duplicity
  test 'email address should be unique and case insensitive' do
    second_user = @user.dup
    second_user.save
    @user.email.upcase!
    assert_not @user.valid?
  end
  
  #Format
  test 'email addreses should be saved as lowercase' do
    @user.email.upcase!
    tempEmail = @user.email
    @user.save
    assert_equal tempEmail.downcase, @user.reload.email
  end
end