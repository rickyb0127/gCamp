require 'rails_helper'

# describe CommentsController do
#   describe "POST #create" do
#     describe "on success" do
#       it "creates a new comment with valid parameters" do
#         expect {
#           user = create_user
#           project = create_project
#           membership = create_membership
#           session[:user_id] = user.id
#           task = create_task(project_id: project.id)
#
#           post :create, project_id: project.id, task_id: task.id, id: comment.id
#         }.to change { Comment.count }.by(1)
#
#         expect(Comment.last.body).to eq "new comment"
#         expect(response.status).to eq(302)
#       end
#     end
#   end
# end
