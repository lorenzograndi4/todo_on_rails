require 'rails_helper'

feature 'Manage tasks', js: true do
  scenario 'add a new task' do
    visit todos_path
    fill_in 'todo_title', with: 'Be Batman'
    page.execute_script("$('form').submit()")
    expect(page).to have_content('Be Batman')
    sleep 5
  end
end
