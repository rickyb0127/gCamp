require 'rails_helper'

feature 'Users' do

  scenario 'User can see a flash message' do
    user = create_user

    visit root_path
    click_on 'Sign In'
    fill_in 'Email', with: 'jp@example.com'
    fill_in 'Password', with: 'wookie'
    within (".well") do click_on 'Sign In'
    end

    visit users_path
    within (".table") do click_on 'Edit'
    end
    fill_in 'First Name', with: 'Joke'
    fill_in 'Password', with: 'new'
    fill_in 'Password Confirmation', with: 'new'
    click_on 'Update User'

    expect(page).to have_content('User was successfully updated')
  end
end
