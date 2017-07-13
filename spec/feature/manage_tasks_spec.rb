require 'rails_helper'

def fill_and_execute
  fill_in 'todo_title', with: 'Be Batman'
  page.execute_script("$('form').submit()")
end

feature 'Manage tasks', js: true do
  scenario 'add a new task' do
    visit todos_path
    fill_and_execute
    expect(page).to have_content('Be Batman')
    sleep 3
  end

  scenario 'counter changes' do
    visit todos_path
    fill_and_execute
    sleep 3
    expect( page.find(:css, 'span#todo-count').text ).to eq "1"
  end

  scenario 'complete a task' do
    visit todos_path
    fill_and_execute
    check('todo-1')
    sleep 3
    expect( page.find(:css, 'span#todo-count').text ).to eq "0"
  end

  scenario 'create 3, check 2' do
    visit todos_path
    fill_and_execute
    fill_and_execute
    fill_and_execute
    check('todo-1')
    check('todo-2')
    sleep 3
    expect( page.find(:css, 'span#todo-count').text ).to eq "1"
    expect( page.find(:css, 'span#total-count').text ).to eq "3"
  end

  scenario 'use clean-up button' do
    visit todos_path
    fill_and_execute
    check('todo-1')
    click_link('clean-up')
    sleep 3
    expect( page.find(:css, 'span#total-count').text ).to eq "0"
  end
end
