require 'rails_helper'

describe CommentsController do
  describe "POST #create" do
    describe "on success" do
      it "creates a new comment with valid parameters" do
        user = create_user
        project = create_project
        session[:user_id] = user.id
        task = create_task(project_id: project.id)

        expect {
          post :create, project_id: project.id, task_id: task.id, comment: { body: "i am a new comment" }
        }.to change { Comment.count }.by(1)

        expect(Comment.last.body).to eq "i am a new comment"
        expect(response.status).to eq(302)
      end
    end

    describe "on failure" do
      it "does not create a new comment without valid parameters" do
        user = create_user
        project = create_project
        session[:user_id] = user.id
        task = create_task(project_id: project.id)

        expect {
          post :create, project_id: project.id, task_id: task.id, comment: { body: " " }
        }.to change { Comment.count }.by(0)

        expect(flash[:error]).to eq "comment can't be blank"
        expect(response.status).to eq(302)
      end
    end
  end
end
