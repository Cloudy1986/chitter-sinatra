# frozen_string_literal: true

feature 'Log out' do
  scenario 'user can log out' do
    User.create(username: 'test', email: 'test@example.com', password: 'password123')
    visit '/log-in'
    fill_in 'email', with: 'test@example.com'
    fill_in 'password', with: 'password123'
    click_button 'Log in'
    click_button 'Log out'
    expect(current_path).to eq '/log-in'
    expect(page).to_not have_content 'Add a new peep'
  end

  scenario 'logged out user cannot access /peeps/new' do
    User.create(username: 'test', email: 'test@example.com', password: 'password123')
    visit '/peeps/new'
    expect(current_path).to eq '/'
  end

  scenario 'logged out user can access /sign-up and /log-in via homepage links and buttons' do
    User.create(username: 'test', email: 'test@example.com', password: 'password123')
    visit '/'
    expect(page).to have_button 'Sign up'
    expect(page).to have_button 'Log in'
    expect(page).to have_link 'Sign up'
    expect(page).to have_link 'Log in'
  end
end
