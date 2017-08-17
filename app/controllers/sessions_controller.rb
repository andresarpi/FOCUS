class SessionsController < ApplicationController
  
  def new
  end
  
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    
    if user && user.authenticate(params[:session][:password])
      
        log_in(user)
        
        if !session[:forwarding_url].nil?
            redirect_back_to_forwarding_url
        else
            render html: "You are correctly logged in"
        end
      
    else
        flash.now[:danger] = "Invalid user/password combo"
        render 'new'
    end
  end
  
  def destroy
    log_out
    ##redirect to root
  end
  
  
end
