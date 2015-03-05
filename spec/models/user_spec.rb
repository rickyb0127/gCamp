require 'rails_helper'

describe User do

  before :each do
    @user = User.create(
      first_name: "Joe",
      last_name: "Random",
      email: "jr@aol.com",
      password: "stuff",
      password_confirmation: "stuff"
    )
  end

  it "can be valid" do

    expect(@user).to be_valid
  end

  it "validates the email is unique" do

    user = User.create(
      first_name: "Ted",
      last_name: "Johnson",
      email: "jr@aol.com",
      password: "new",
      password_confirmation: "new"
      )

    expect(user.errors[:email]).to include("has already been taken")
  end
end
