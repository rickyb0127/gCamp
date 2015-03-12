class CommentsController < ApplicationController

  def create
    @project = Project.find(params[:project_id])
    @task = Task.find(params[:task_id])
    @comment = @task.comments.new(comment_params.merge(user_id: current_user.id))
    if @comment.save
      redirect_to project_task_path(@task.project_id, @task)
    else
      redirect_to project_task_path(@task.project_id, @task)
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
