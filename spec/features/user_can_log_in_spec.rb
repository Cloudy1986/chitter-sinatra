# frozen_string_literal: true

feature 'Log in' do
  scenario 'user successfully logs in with correct email' do
    User.create(username: 'test', email: 'test@example.com', password: 'password123')
    visit '/log-in'
    fill_in 'email', with: 'test@example.com'
    fill_in 'password', with: 'password123'
    click_button 'Log in'
    expect(current_path).to eq '/peeps'
    expect(page).to have_content 'You are logged in as test'
  end

  scenario 'user cannot log in with incorrect email' do
    User.create(username: 'test', email: 'test@example.com', password: 'password123')
    visit '/log-in'
    fill_in 'email', with: 'incorrect@example.com'
    fill_in 'password', with: 'password123'
    click_button 'Log in'
    expect(current_path).to eq '/log-in'
    expect(page).to_not have_content 'You are logged in as test'
    expect(page).to have_content 'Please check your email or password'
  end

  scenario 'user cannot log in with incorrect password' do
    User.create(username: 'test', email: 'test@example.com', password: 'password123')
    visit '/log-in'
    fill_in 'email', with: 'test@example.com'
    fill_in 'password', with: 'incorrectpassword'
    click_button 'Log in'
    expect(current_path).to eq '/log-in'
    expect(page).to_not have_content 'You are logged in as test'
    expect(page).to have_content 'Please check your email or password'
  end

  scenario 'logged in user cannot access /sign-up or /log-in' do
    User.create(username: 'test', email: 'test@example.com', password: 'password123')
    visit '/log-in'
    fill_in 'email', with: 'test@example.com'
    fill_in 'password', with: 'password123'
    click_button 'Log in'
    visit '/sign-up'
    expect(current_path).to eq '/peeps'
    visit '/log-in'
    expect(current_path).to eq '/peeps'
  end

  scenario 'logged in user cannot access /sign-up and /log-in via homepage links and buttons' do
    User.create(username: 'test', email: 'test@example.com', password: 'password123')
    visit '/log-in'
    fill_in 'email', with: 'test@example.com'
    fill_in 'password', with: 'password123'
    click_button 'Log in'
    visit '/'
    expect(page).to_not have_button 'Sign up'
    expect(page).to_not have_button 'Log in'
    expect(page).to_not have_link 'Sign up'
    expect(page).to_not have_link 'Log in'
  end

  scenario 'logged in user can access /peeps/new via homepage link' do
    User.create(username: 'test', email: 'test@example.com', password: 'password123')
    visit '/log-in'
    fill_in 'email', with: 'test@example.com'
    fill_in 'password', with: 'password123'
    click_button 'Log in'
    visit '/'
    expect(page).to have_link 'Add a new peep'
    click_link 'Add a new peep'
    expect(current_path).to eq '/peeps/new'
  end
end
