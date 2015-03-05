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
    Task.create!(
      description: 'My task'
    )

    visit tasks_path
    click_on 'Edit'
    fill_in 'Description', with: 'new stuff'
    click_on 'Update Task'

    expect(page).to have_content('Task was successfully updated')
  end

end
