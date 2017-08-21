module SessionsHelper
    def log_in(user)
       session[:user_id] = user.id 
    end
    
    def current_user
      if (user_id = session[:user_id])
        @current_user ||= User.find_by(id: user_id)
      elsif (user_id = cookies.signed[:user_id])
        user = User.find_by(id: user_id)
        if user && user.authenticated?(cookies[:remember_token])
          log_in user
          @current_user = user
        end
      end
    end
    
    def remember(user)
      user.remember
      cookies.permanent.signed[:user_id] = user.id
      cookies.permanent[:remember_token] = user.remember_token
    end
    
    def is_logged_in?
      !session[:user_id].nil?
    end
    
    def forget(user)
      user.forget
      cookies.delete(:user_id)
      cookies.delete(:remember_token)
    end
    
    def log_out
      forget(current_user)
      session.delete(:user_id)
      @user = nil
    end
    
    # Redirects to stored location (or to the default).
    def redirect_back_after_login(user)
      if session[:forwarding_url].nil?
        redirect_to user
      else
        redirect_to(session[:forwarding_url])
        session.delete(:forwarding_url)
      end
    end
    
    # Stores the URL trying to be accessed.
    def store_location
      session[:forwarding_url] = request.original_url if request.get?
    end
    
end
