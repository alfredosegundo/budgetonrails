class SessionsController  < ApplicationController
	skip_before_action :require_login, only: [:create]
	def create
    	auth = request.env["omniauth.auth"]
    	user = Contributor.find_by_email(auth["info"]["email"]) if auth
    	if user
    		reset_session
    		session[:user_id] = user.id
    		session[:user_image] = auth["info"]["image"]
		    redirect_to root_url, notice: "Logged in!"
    	else
    		redirect_to root_url, notice: 'Login fail!'
    	end
	end

	def destroy
		reset_session
		redirect_to root_url, notice: "You have successfully logged out."
	end
end
