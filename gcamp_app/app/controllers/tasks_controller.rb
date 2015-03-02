class TasksController < ApplicationController
  before_action :get_task, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = Task.all
    unless current_user
      redirect_to sign_in_path
      flash[:error] = "You must sign in"
    end
  end

  def show

  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      flash[:notice] = "Task was successfully created"
      redirect_to task_path(@task)
    else
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

  def get_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:description, :complete, :due_date)
  end
end
