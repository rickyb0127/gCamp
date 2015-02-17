class UsersController < ApplicationController
  before_action :get_user, only: [:show, :edit, :update, :destroy]

  def get_user
    @user = User.find(params[:id])
  end

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
      @user = User.new(user_params)
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
    redirect_to users_path
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email)
  end
end
