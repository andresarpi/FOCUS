class SurveysController < ApplicationController
  
  before_action :isUserLoggedIn, only: [:new, :create]
  
  def new
    @survey = Survey.new
  end
  
  def create
    @survey = Survey.new(survey_params)
    @survey.created_at = DateTime.now
    user = current_user
    @survey.user_id = user.id
    if @survey.save
      redirect_to user
    else
      flash.now[:danger] = "Ops, there was a problem with your survey"
      render 'new'
    end
  end
  
  private
    def survey_params
      params.require(:survey).permit(:feeling, :focus, :activity_id)
    end
    
    def isUserLoggedIn
      if !is_logged_in?
        store_location
        flash[:warning] = "Log in first to complete a survey"
        redirect_to login_path
      end
    end
end
