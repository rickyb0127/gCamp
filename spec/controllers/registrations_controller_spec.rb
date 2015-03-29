require 'rails_helper'

describe RegistrationsController do
  describe "GET #new" do
    it 'creates a new instance of a user' do

      get :new

      expect(assigns(:user)).to be_a_new(User)
    end
  end

  describe "POST #create" do
    describe "on success" do
      it 'create a new user with valid parameters' do

        expect {
          post :create, user: { first_name: 'new', last_name: 'guy', email: 'blue@example.com', password: 'wookie' }
        }.to change { User.count }.by(1)

        expect(flash[:notice]).to eq "You have successfully signed up"
        expect(response).to redirect_to new_project_path
      end
    end
  end
end
