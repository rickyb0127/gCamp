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
          user = create_user(email: "new@example.com")
          project = create_project
          membership = create_membership
          session[:user_id] = user.id
          post :create, project_id: project
        }.to change { Membership.count }.by(1)

        expect(Membership.last.role).to eq "Member"
        expect(response.status).to eq(302)
      end
    end
  end

  # describe "PATCH #update" do
  #   describe "on success" do
  #     it "updates a membership with valid parameters" do
  #       user = create_user(email: "boom@example.com")
  #       session[:user_id] = user.id
  #       project = create_project
  #       user2 = create_user(email: "random@example.com")
  #       membership = create_membership(user_id: user.id, project_id: project.id, role: 'Owner')
  #       membership2 = create_membership(user_id: user.id, project_id: project.id, role: 'Member')
  #
  #       expect {
  #         patch :update, project_id: project.id, id: membership2.id, membership:{ role: 'Owner' }
  #       }.to change { membership2.reload.role }.from('Member').to('Owner')
  #
  #       expect(flash[:notice]).to eq 'Membership was successfully updated'
  #       expect(response.status).to eq(302)
  #     end
  #   end
  # end

  describe "DELETE #destroy" do
    describe "on success" do
      it "deletes a membership" do
        project = create_project
        user = create_user(email: "snail@example.com")
        membership = create_membership
        session[:user_id] = user.id

        delete :destroy, project_id: project.id, id: membership.id

        Membership.last.destroy

        expect(Membership.all).to eq []
      end
    end
  end
end
