require 'rails_helper'

describe MembershipsController do
  describe "GET #index" do
    it "assigns a new membership for project" do
      user = create_user(email: "foo@example.com")
      project = create_project
      membership = create_membership(user_id: user.id, project_id: project.id)
      session[:user_id] = user.id
      get :index, { :project_id => project.id }

      expect(assigns(:membership)).to be_a_new(Membership)
    end
  end

  describe "POST #create" do
    describe "on success" do
      it "creates a new membership with valid parameters" do
        expect {
          project = create_project
          user = create_user(email: "snail@example.com")
          membership = create_membership
          session[:user_id] = user.id
          post :create, project_id: project
        }.to change { Membership.count }.by(1)

        expect(Membership.last.role).to eq "Member"
# binding.pry
#         expect(flash[:notice]).to match(/Joe Person was successfully added/)
#         expect(response).to redirect_to project_memberships_path(@project)
      end
    end
  end

  describe "PATCH #update" do
    describe "on success" do
      it "updates a membership with valid parameters" do
        project = create_project
        user = create_user(email: "snail@example.com")
        membership = create_membership
        session[:user_id] = user.id
        post :create, project_id: project
        Membership.last.update(role: "Owner")
# binding.pry
#       expect(Membership.last.role).to eq "Owner"
#       expect(flash[:notice]).to match(/Joe Person was successfully updated/)
#       expect(response).to redirect_to project_memberships_path(@project)
      end
    end
  end

  describe "DELETE #destroy" do
    describe "on success" do
      it "deletes a membership" do
        project = create_project
        user = create_user(email: "snail@example.com")
        membership = create_membership
        session[:user_id] = user.id
        post :create, project_id: project
        Membership.last.destroy

        expect(Membership.all).to eq []
# binding.pry
#         expect(flash[:notice]).to match(/Joe Person was successfully removed/)
#         expect(response).to redirect_to projects_path
      end
    end
  end
end
