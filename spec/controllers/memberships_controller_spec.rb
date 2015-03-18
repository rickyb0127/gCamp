require 'rails_helper'

describe MembershipsController do
  describe "GET #index" do
    it "assigns a new membership for project" do
      project = create_project
      get :index, { :project_id => project }

      expect(assigns(:membership)).to be_a_new(Membership)
    end
  end

  describe "POST #create" do
    describe "on success" do
      it "creates a new a new membership with valid parameters" do
        expect {
          project = create_project
          user = create_user
          post :create, project_id: project, membership: { project_id: project.id, user_id: user.id, role: "Member" }
        }.to change { Membership.count }.by(1)

        membership = Membership.last
        expect(membership.role).to eq "Member"
        expect(response).to redirect_to project_memberships_path
      end
    end
  end

end
