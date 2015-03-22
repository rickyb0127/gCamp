class MembershipsController < ApplicationController
  before_action :set_project
  before_action :authorize_project, only: [:index]
  before_action :authorize_owner, only: [:create, :update]
  before_action :ensure_at_least_one_owner, only: [:update]

  def index
    @membership = @project.memberships.new
  end

  def create
    @membership = @project.memberships.new(membership_params)
    if @membership.save
      flash[:notice] = @membership.user.full_name + " " + "was successfully added"
      redirect_to project_memberships_path(@project)
    else
      render :index
    end
  end

  def update
    @membership = Membership.find(params[:id])
    if @membership.update(membership_params)
      flash[:notice] = @membership.user.full_name + " " + "was successfully updated"
      redirect_to project_memberships_path(@project)
    else
      render :index
    end
  end

  def destroy
    @membership = Membership.find(params[:id])
    @membership.destroy
    flash[:notice] = @membership.user.full_name + " " + "was successfully removed"
    redirect_to projects_path
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def membership_params
    params.require(:membership).permit(:user_id, :project_id, :role)
  end

  def authorize_owner
    unless @project.memberships.where(user_id: current_user.id).pluck(:role) == ["Owner"] || current_user.admin == true
      flash[:error] = "You do not have access"
      redirect_to project_path(@project)
    end
  end

  def ensure_at_least_one_owner
    @membership = Membership.find(params[:id])
    if @membership.role == "Owner" && @project.memberships.where(role: "Owner").count <= 1
      flash[:error] = "Projects must have at least one owner"
      redirect_to project_memberships_path(@project)
    end
  end
end
