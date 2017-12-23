class SurveysController < ApplicationController
  
  before_action :isUserLoggedIn, only: [:new, :create, :show]
  
  def index
    user = User.find params[:user_id]
    if user
      render json: user.surveys
    else
      render json: {status: 404, errors: "Couldn't find the user specified"}
    end
    
  end
  
  def show
  end
  
  def new
    @user = current_user
    @survey = Survey.new
  end
  
  def general_new
    if is_logged_in?
      user = current_user
      redirect_to new_user_survey_path(user)
    else
      flash[:warning] = "Log in first to complete a survey"
      session[:came_from_email] = true
      redirect_to login_path
    end
  end
  
  def create
    @survey = Survey.new(survey_params)
    @user = current_user
    @survey.user_id = @user.id
    if @survey.save
      redirect_to @user
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
