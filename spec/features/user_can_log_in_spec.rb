feature 'Log in' do
  scenario 'user successfully logs in with correct email' do
    User.create(username: 'test', email: 'test@example.com', password: 'password123')
    visit '/log-in'
    fill_in 'username', with: 'test'
    fill_in 'email', with: 'test@example.com'
    fill_in 'password', with: 'password123'
    click_button 'Log in'
    expect(current_path).to eq '/peeps'
    expect(page).to have_content 'You are logged in as test'
  end

  scenario 'user cannot log in with incorrect email' do
    User.create(username: 'test', email: 'test@example.com', password: 'password123')
    visit '/log-in'
    fill_in 'username', with: 'test'
    fill_in 'email', with: 'incorrect@example.com'
    fill_in 'password', with: 'password123'
    click_button 'Log in'
    expect(current_path).to eq '/log-in'
    expect(page).to_not have_content 'You are logged in as test'
  end

  # scenario 'user cannot log in with incorrect password' do
    
  # end


end