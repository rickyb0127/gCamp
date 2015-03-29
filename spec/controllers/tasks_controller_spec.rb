require 'rails_helper'

describe TasksController do

  describe "GET #index" do
    it "lists all tasks" do
      user = create_user
      session[:user_id] = user.id
      project = create_project
      task = create_task

      get :index, project_id: project.id

      expect(Task.all).to include(Task.last)
    end
  end

  describe "GET #new" do
    it "creates a new instance of a task" do
      user = create_user
      session[:user_id] = user.id
      project = create_project

      task = Task.new

      get :new, project_id: project.id

      expect(task).to be_a_new(Task)
    end
  end

  describe "POST #create" do
    describe "on success" do
      it "creates a new task with valid parameters" do
        user = create_user
        project = create_project
        session[:user_id] = user.id

        expect {
          post :create, project_id: project.id, task: { description: "more stuff" }
        }.to change { Task.count }.by(1)

        expect(Task.last.description).to eq "more stuff"
        expect(response.status).to eq(302)
      end
    end
  end

  describe "GET #edit" do
    describe "on success" do
      it "renders an edit form for a given task" do
        user = create_user
        session[:user_id] = user.id
        project = create_project
        task = create_task(project_id: project.id)

        get :edit, project_id: project.id, id: task.id

        expect(assigns(:task)).to eq task
        expect(response).to render_template :edit
      end
    end
  end

  describe "PATCH #update" do
    describe "on success" do
      it "updates a task with valid parameters" do
        user = create_user
        session[:user_id] = user.id
        project = create_project
        task = create_task(project_id: project.id)

        expect {
          patch :update, project_id: project.id, id: task.id, task:{ description: 'hahaha' }
        }.to change { task.reload.description }.from('do stuff').to('hahaha')

        expect(flash[:notice]).to eq 'Task was successfully updated'
        expect(response).to redirect_to projects_path
      end
    end
  end

  describe "GET #show" do
    describe "on success" do
      it "shows a task for a project" do
        user = create_user
        session[:user_id] = user.id
        project = create_project
        task = create_task(project_id: project.id)

        get :show, project_id: project.id, id: task.id

        expect(assigns(:task)).to be_a(Task)
      end
    end
  end

  describe "DELETE #destroy" do
    describe "on success" do
      it "deletes a task" do
        project = create_project
        user = create_user(email: "snail@example.com")
        session[:user_id] = user.id
        task = create_task(project_id: project.id)

        delete :destroy, project_id: project.id, id: task.id

        expect(Task.all).to eq []
      end
    end
  end
end
