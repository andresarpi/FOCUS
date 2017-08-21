class SessionsController < ApplicationController
  
  def new
  end
  
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in(user)
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_back_after_login(user)
    else
      flash.now[:danger] = "Invalid user/password combo"
      render 'new'
    end
  end
  
  def destroy
    log_out if is_logged_in?
    ##redirect to root
  end
  
  
end
