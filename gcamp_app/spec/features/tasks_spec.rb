require 'rails_helper'

feature 'Tasks' do

  scenario 'User can see a flash message' do
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
