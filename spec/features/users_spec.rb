require 'rails_helper'

feature 'Users' do

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

    visit users_path
    within (".table") do click_on 'Test Man'
    end
    click_on 'Edit'
    fill_in 'First Name', with: 'Joke'
    fill_in 'Password', with: 'new'
    fill_in 'Password Confirmation', with: 'new'
    click_on 'Update User'

    expect(page).to have_content('User was successfully updated')
  end
end
