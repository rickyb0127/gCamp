class TasksController < ApplicationController
  before_action :set_project, only: [:index, :show, :new, :create, :edit]
  before_action :authorize
  before_action :authorize_project, only: [:index]

  def index
    @tasks = @project.tasks.all
  end

  def show
    @task = @project.tasks.find(params[:id])
    @comments = @task.comments.all
    @comment = @task.comments.new
  end

  def new
    @task = @project.tasks.new
  end

  def create
    @task = @project.tasks.new(task_params)
    if @task.save
      flash[:notice] = "Task was successfully created"
      redirect_to project_task_path(@project, @task)
    else
      render :new
    end
  end

  def edit
    @task = @project.tasks.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      flash[:notice] = "Task was successfully updated"
      redirect_to projects_path
    else
      render :edit
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to project_tasks_path
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def task_params
    params.require(:task).permit(:description, :complete, :due_date)
  end
end
