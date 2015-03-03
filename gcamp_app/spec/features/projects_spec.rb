require 'rails_helper'

feature 'Projects' do

  scenario 'User can see a flash message' do

    visit root_path
    click_on 'Sign Up'
    fill_in 'First Name', with: 'Test'
    fill_in 'Last Name', with: "Man"
    fill_in 'Email', with: 'testman@example.com'
    fill_in 'Password', with: 'new'
    fill_in 'Password Confirmation', with: 'new'
    within (".well") do click_on 'Sign Up'
    end

    visit projects_path
    click_on 'New Project'
    fill_in 'Name', with: 'test'
    click_on 'Create Project'

    expect(page).to have_content('Project was successfully created')
  end

end
