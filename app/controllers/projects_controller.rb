class ProjectsController < ApplicationController
  before_action :authorize
  before_action :set_project, only: [:edit, :update, :show, :destroy]
  before_action :authorize_project, only:[:show]
  before_action :owner_or_admin, only:[:edit, :destroy, :update]

  def index
    @projects = current_user.projects
    @all_projects = Project.all
    @task = Task.new
    tracker_api = TrackerAPI.new
    if current_user.pivotal_tracker_token
      @tracker_projects = tracker_api.projects(current_user.pivotal_tracker_token)
    end
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

  end

  def update
    if @project.update(project_params)
      flash[:notice] = "Project was successfully updated"
      redirect_to action: "show"
    else
      render :edit
    end
  end

  def show

  end

  def destroy
    @project.destroy
    flash[:notice] = "Project was successfully deleted"
    redirect_to projects_path
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name)
  end
end
