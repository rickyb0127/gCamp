class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user
  helper_method :owner_or_admin
  before_action :authorize
  before_filter :store_location

  def store_location
    if (!request.fullpath.match("/sign-in") && !request.xhr?)
      session[:user_return_to] = request.fullpath
    end
  end

  def after_sign_in_path_for
    session[:user_return_to] || request.referrer || root_path
  end

  def authorize_project
    unless @project.users.pluck(:id).include?(current_user.id)
      flash[:error] = "You do not have access to that project"
      redirect_to projects_path
    end
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
    rescue ActiveRecord::RecordNotFound
  end

  def authorize
    unless current_user
      flash[:error] = "You must sign in"
      redirect_to sign_in_path
    end
  end

  def owner_or_admin
    unless current_user.admin == true || @project.memberships.where(user_id: current_user.id).pluck(:role) == ["Owner"]
      flash[:error] = "You do not have access"
      redirect_to project_path(@project)
    end
  end
end
