require 'test_helper'

class SurveysTest < ActionDispatch::IntegrationTest
  
  test 'get new survey template' do
    get new_survey_path
    assert_template 'surveys/new'
  end
   
  test "invalid survey information" do

    assert_no_difference 'Survey.count' do
      post surveys_path, params: { survey: { feeling:  "", activity_id: 0, focus: ""} }
    end
    assert_template 'surveys/new'
  end
  
end
