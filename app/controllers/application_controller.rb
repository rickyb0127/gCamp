class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user

  def current_user
    if session[:user_id].present?
      User.find(session[:user_id])
    end
  end
  
  def authorize
    unless current_user
      redirect_to sign_in_path
      flash[:error] = "You must sign in"
    end
  end
end
