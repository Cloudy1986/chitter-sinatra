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
end
