require 'rails_helper'

describe Project do

  before :each do
    @project = Project.create(
      name: "Project X"
    )
  end

  it "can be valid" do
    expect(@project).to be_valid
  end
end
