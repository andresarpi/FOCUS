class UsersController < ApplicationController
  def show
      @user = User.find(params[:id])
  end
  
  def myprofile
    if is_logged_in?
      @user = current_user
      render 'show'
    else
      redirect_to login_path
    end
  end

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user
    else
      flash.now[:danger] = "Ops, there was a problem with your information"
      render 'new'
    end
  end
  
  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
