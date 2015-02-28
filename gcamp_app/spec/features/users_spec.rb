require 'rails_helper'

feature 'Users' do

  scenario 'User can see a flash message' do
    User.create!(
      first_name: 'Joe',
      last_name: 'Randa',
      email: 'joeranda@example.com'
    )

    visit users_path
    click_on 'Edit'
    fill_in 'First Name', with: 'Joke'
    click_on 'Update User'

    expect(page).to have_content('User was successfully updated')
  end

end
