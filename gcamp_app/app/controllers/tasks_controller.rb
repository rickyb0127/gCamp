class TasksController < ApplicationController
  before_action :get_task, only: [:show, :edit, :update, :destroy]

  def get_task
    @task = Task.find(params[:id])
  end

  def index
    @tasks = Task.all
  end

  def show

  end

  def new
    @task = Task.all
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      flash[:notice] = "Task was successfully created"
      render :show
    else
      @task = Task.new(task_params)
      render :new
    end
  end

  def edit

  end

  def update
    if @task.update(task_params)
      flash[:notice] = "Task was successfully updated"
      redirect_to action: "show"
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path
  end

  private

  def task_params
    params.require(:task).permit(:title)
  end
end
