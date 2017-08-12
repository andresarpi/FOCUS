require 'test_helper'

class SurveyTest < ActiveSupport::TestCase
include FactoryGirl::Syntax::Methods
  
  def setup 
    @user = create(:user) #User.new(name: "Andres Arpi", email: "aarpi@itba.edu.ar", password: "123456"
    @survey = build(:survey) #     feeling 45,   focus 30,    activity_id 4
    @survey.user_id = @user.id
  end
  
  test 'should be valid?' do
    assert @survey.valid?
  end
  
  ##Presence
    test 'feeling should be present' do
      @survey.feeling = nil
      assert_not @survey.valid?
    end
    
    test 'focus should be present' do
      @survey.focus = nil
      assert_not @survey.valid?
    end
    
    test 'activity_id should be present' do
      @survey.activity_id = nil
      assert_not @survey.valid?
    end
    
    test 'user_id should be present' do
      @survey.user_id = nil
      assert_not @survey.valid?
    end
    
    
  
  ##Format
    test 'feeling should be integer' do
      @survey.feeling = "xxx"
      assert_not @survey.valid?
    end
    
    test 'feeling should between 1 and 100' do
      @survey.feeling = 102
      assert_not @survey.valid?
      @survey.feeling = 0
      assert_not @survey.valid?
    end
    
    test 'focus should be integer' do
      @survey.focus = "xxx"
      assert_not @survey.valid?
    end
    
    test 'focus should between 1 and 100' do
      @survey.focus = 102
      assert_not @survey.valid?
      @survey.focus = 0
      assert_not @survey.valid?
    end
end
