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
    
    # Redirects to stored location (or to the default).
    def redirect_back_to_forwarding_url
      redirect_to(session[:forwarding_url])
      session.delete(:forwarding_url)
    end
    
    # Stores the URL trying to be accessed.
    def store_location
      session[:forwarding_url] = request.original_url if request.get?
    end
    
end
