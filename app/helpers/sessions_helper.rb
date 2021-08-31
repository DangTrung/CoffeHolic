module SessionsHelper
	private
	
	def log_in user
		session[:user_id] = user.id
	end

	def current_user
		if user_id = session[:user_id]
			@current_user ||= User.find_by id: session[:user_id]
		elsif user_id = cookies.signed[:user_id]
			user = User.find_by id: user_id
			if user&.authenticated?(:remember, cookies[:remember_token])
				log_in user_id
        		@current_user = user
        	end
        end
	end

	def log_in?
		current_user.present?
	end

 	def log_out
 		forget current_user
 		session.delete(:user_id)
    	@current_user = nil
    end

    def forget user
	    user.forgot
	    cookies.delete(:user_id)
	    cookies.delete(:remember_token)
  	end

	def remember user
	    user.remember
	    cookies.permanent.signed[:user_id] = user.id
	    cookies.permanent[:remember_token] = user.remember_token
  	end

	def redirect_back_or default
	    redirect_to( session[:forwarding_url] || default)
	    session.delete(:forwarding_url)
  	end

  	def store_location
    	session[:forwarding_url] = request if request.get?
  	end

  	def log_in_users
	    unless log_in?
	    	store_location
	      	flash[:danger] = "Please log in first"
	     	redirect_to login_url
	    end
  	end

end
