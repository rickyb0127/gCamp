class MembershipsController < ApplicationController
  before_action :set_project

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
    redirect_to project_memberships_path(@project)
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def membership_params
    params.require(:membership).permit(:user_id, :project_id, :role)
  end
end
