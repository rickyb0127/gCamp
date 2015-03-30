require 'rails_helper'

describe ProjectsController do

  describe "GET #index" do
    it "lists all projects" do
      user = create_user(email: "wookie@example.com")
      project = create_project
      membership = create_membership(project, user)
      session[:user_id] = user.id
      get :index

      expect(Project.all).to include(Project.last)
    end
  end

  describe "GET #new" do
    it "creates a new instance of a project" do
      project = Project.new
      get :new

      expect(project).to be_a_new(Project)
    end
  end

  describe "POST #create" do
    describe "on success" do
      it "creates a new project with valid parameters and merges membership role to 'owner'" do
        user = create_user
        session[:user_id] = user.id

        expect {
          post :create, project: { name: 'new' }
        }.to change { Project.count }.by(1)

        expect(flash[:notice]).to eq 'Project was successfully created'
        expect(user.memberships.last.role).to eq 'Owner'
        expect(response).to redirect_to project_tasks_path(user.projects.last)
        expect(response.status).to eq(302)
      end
    end
  end

  describe "GET #edit" do
    describe "on success" do
      it "renders an edit form for a given project" do
        user = create_user(email: "new@example.com")
        session[:user_id] = user.id
        project = create_project
        membership = create_membership(project, user, role: 'Owner')

        get :edit, id: project.id

        expect(assigns(:project)).to eq project
        expect(response).to render_template :edit
      end
    end
  end

  describe "PATCH #update" do
    describe "on success" do
      it "updates a project with valid parameters" do
        user = create_user(email: "random@example.com")
        session[:user_id] = user.id
        project = create_project
        membership = create_membership(project, user, role: 'Owner')

        expect {
          patch :update, id: project.id, project:{ name: 'updated project' }
        }.to change { project.reload.name }.from('Awesome Project').to('updated project')

        expect(flash[:notice]).to eq 'Project was successfully updated'
        expect(response).to redirect_to project_path(project)
      end
    end
  end

  describe "GET #show" do
    describe "on success" do
      it "shows a project if current user is owner" do
        user = create_user(email: "green@example.com")
        session[:user_id] = user.id
        project = create_project
        membership = create_membership(project, user, role: 'Owner')

        get :show, id: project.id

        expect(assigns(:project)).to be_a(Project)
      end
    end
  end

  describe "DELETE #destroy" do
    describe "on success" do
      it "deletes a membership" do
        project = create_project
        user = create_user(email: "snail@example.com")
        membership = create_membership(project, user, role: 'Owner')
        session[:user_id] = user.id

        delete :destroy, id: project.id

        expect(Project.all).to eq []
      end
    end
  end
end
