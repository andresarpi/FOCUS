module SessionsHelper
    def log_in(user)
       session[:user_id] = user.id 
    end
    
    def current_user
        @user ||= User.find_by(id: session[:user_id])
    end
    
    def is_logged_in?
        !session[:user_id].nil?
    end
    
    def log_out
        session.delete(:user_id)
        @user = nil
    end
    
end
