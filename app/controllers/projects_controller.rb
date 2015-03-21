class ProjectsController < ApplicationController
  before_action :authorize

  def index
    @projects = current_user.projects
    @task = Task.new
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      @project.memberships.create(user_id: current_user.id, role: "Owner")
      flash[:notice] = "Project was successfully created"
      redirect_to project_tasks_path(@project)
    else
      render :new
    end
  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])
    if @project.update(project_params)
      flash[:notice] = "Project was successfully updated"
      redirect_to action: "show"
    else
      render :edit
    end
  end

  def show
    @project = Project.find(params[:id])
    unless @project.users.pluck(:id).include?(current_user.id)
      flash[:error] = "You do not have access to that project"
      redirect_to projects_path
    end
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    flash[:notice] = "Project was successfully deleted"
    redirect_to projects_path
  end

  private

  def project_params
    params.require(:project).permit(:name)
  end
end
