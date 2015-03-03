require 'rails_helper'

feature 'Guests' do

  scenario 'Guest can sign up successfully' do

    visit root_path
    click_on 'Sign Up'
    fill_in 'First Name', with: 'Test'
    fill_in 'Last Name', with: "Man"
    fill_in 'Email', with: 'testman@example.com'
    fill_in 'Password', with: 'new'
    fill_in 'Password Confirmation', with: 'new'
    within (".well") do click_on 'Sign Up'
    end

    expect(current_path).to eq '/'
    expect(page).to have_content('You have successfully signed up')
  end
  
end
