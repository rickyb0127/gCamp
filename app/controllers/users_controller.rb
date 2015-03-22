class UsersController < ApplicationController
  before_action :get_user, only: [:show, :edit, :update, :destroy]
  before_action :authorize
  before_action :require_login, only: [:edit, :update, :destroy]

  def index
    @users = User.all
  end

  def show

  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "User was successfully created"
      redirect_to action: "index"
    else
      render :new
    end
  end

  def edit

  end

  def update
    if @user.update(user_params)
      flash[:notice] = "User was successfully updated"
      redirect_to action: "index"
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    flash[:notice] = "User was successfully deleted"
    redirect_to "/"
  end

  private

  def get_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

  def require_login
    unless current_user.id == @user.id
      render file: 'public/404.html', status: :not_found, layout: false
    end
  end
end
