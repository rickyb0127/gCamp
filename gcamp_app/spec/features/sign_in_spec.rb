require 'rails_helper'

feature 'Users' do

  scenario 'User can sign in successfully' do

    visit root_path
    click_on 'Sign Up'
    fill_in 'First Name', with: 'Test'
    fill_in 'Last Name', with: "Man"
    fill_in 'Email', with: 'testman@example.com'
    fill_in 'Password', with: 'new'
    fill_in 'Password Confirmation', with: 'new'
    within (".well") do click_on 'Sign Up'
    end

    click_on 'Sign Out'

    click_on 'Sign In'
    fill_in 'Email', with: 'testman@example.com'
    fill_in 'Password', with: 'new'
    within (".well") do click_on 'Sign In'
    end

    expect(current_path).to eq '/'
    expect(page).to have_content('You are successfully signed in')
  end

end
