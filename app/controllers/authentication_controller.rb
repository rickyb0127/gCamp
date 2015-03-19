class AuthenticationController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to projects_path
      flash[:notice] = "You are successfully signed in"
    else
      @user = User.new
      @user.errors[:email] << ' / Password combination is invalid'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
    flash[:notice] = "You have successfully signed out"
  end
end
