require 'rails_helper'

feature 'Tasks' do

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
    within (".new-project-header") do click_on 'New Project'
    end
    fill_in 'Name', with: 'test'
    click_on 'Create Project'
    click_on "Tasks"
    click_on "New Task"
    fill_in 'Description', with: "stuff"
    fill_in "Due", with: '2015-01-01'
    click_on 'Create Task'

    expect(page).to have_content('Task was successfully created')
  end

end
