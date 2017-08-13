require 'test_helper'

class SurveyTest < ActiveSupport::TestCase
include FactoryGirl::Syntax::Methods
  
  def setup 
    @user = create(:user) #User.new(name: "Andres Arpi", email: "aarpi@itba.edu.ar", password: "123456"
    @survey = build(:survey) #     feeling 45,   focus 30,    activity_id 4
    @survey.user_id = @user.id
    @activity = create(:activity)
    @survey.activity_id = @activity.id
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
    
    #Associations
      test 'should return user' do
        assert (@survey.user.id == @user.id)
      end
      
      test 'should delete survey should user be deleted' do
        @user.destroy
        survey = Survey.find_by(id: @survey.id)
        assert(survey == nil)
      end
      
      test 'user_id should be valid' do
        @survey.user_id = 1000000000000
        assert_not @survey.valid?
      end
      
      test 'should return activity' do
        assert (@survey.activity.name == @activity.name)
      end
      
      test 'activity should exist' do
        @survey.activity_id = 100
        assert_not @survey.valid?
      end
      

end
