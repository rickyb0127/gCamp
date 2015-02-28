require 'rails_helper'

feature 'Projects' do

  scenario 'User can see a flash message' do
    Project.create!(
      name: "new project"
    )

    visit projects_path
    click_on 'New Project'
    fill_in 'Name', with: 'test'
    click_on 'Create Project'

    expect(page).to have_content('Project was successfully created')
  end

end
