require 'rails_helper'

describe Task do
  before :each do
    @task = Task.create(
      description: "My Task"
    )
  end

  it "can be valid" do
    expect(@task).to be_valid
  end
end
