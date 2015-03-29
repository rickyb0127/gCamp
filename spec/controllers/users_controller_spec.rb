require 'rails_helper'

describe UsersController do

  describe "GET #index" do
    it "lists all user" do
      user = create_user
      session[:user_id] = user.id

      get :index

      expect(User.all).to include(User.last)
    end
  end

  describe "GET #new" do
    it "creates a new instance of a user" do
      user = User.new

      get :new

      expect(user).to be_a_new(User)
    end
  end

  describe "POST #create" do
    describe "on success" do
      it "creates a new user with valid parameters" do
        user = create_user
        session[:user_id] = user.id

        expect {
          post :create, user: { first_name: 'new', last_name: 'guy', email: 'blue@example.com', password: 'wookie' }
        }.to change { User.count }.by(1)

        expect(flash[:notice]).to eq "User was successfully created"
        expect(response).to redirect_to action: "index"
      end
    end
  end

  describe "GET #edit" do
    describe "on success" do
      it "renders an edit form for a given user" do
        user = create_user
        session[:user_id] = user.id

        get :edit, id: user.id

        expect(assigns(:user)).to eq user
        expect(response).to render_template :edit
      end
    end
  end

  describe "PATCH #update" do
    describe "on success" do
      it "updates a user with valid parameters" do
        user = create_user
        session[:user_id] = user.id

        expect {
          patch :update, id: user.id, user:{ first_name: 'hans' }
        }.to change { user.reload.first_name }.from('Joe').to('hans')

        expect(flash[:notice]).to eq 'User was successfully updated'
        expect(response).to redirect_to action: "index"
      end
    end
  end

  describe "GET #show" do
    describe "on success" do
      it "shows user's full name" do
        user = create_user
        session[:user_id] = user.id

        get :show, id: user.id

        expect(assigns(:user)).to be_a(User)
      end
    end
  end

  describe "DELETE #destroy" do
    describe "on success" do
      it "deletes a user" do
        user = create_user
        session[:user_id] = user.id

        delete :destroy, id: user.id

        expect(User.all).to eq []
      end
    end
  end
end
