class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :user_image
  before_action :require_login
 
  private
	 
	  def require_login
	    unless logged_in?
	      redirect_to root_url, error: "You must be logged in to access this section"
	    end
	  end

	  def logged_in?
	  	session[:user_id]
	  end

	  def current_user
	    @current_user ||= Contributor.find(session[:user_id]) if session[:user_id]
	  end

	  def user_image
	  	session[:user_image]
	  end
end
