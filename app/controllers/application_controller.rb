class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  
  protect_from_forgery with: :exception
  
  def current_user
  	if session[:current_user].present?
	    @current_user = User.find(session[:current_user]['id'])
	  else
		  nil
	  end
  end	

  def authenticate_user!
    if current_user.blank?
      flash[:error] = "Please login to continue "
      redirect_to sign_in_users_path
    end
  end

end
