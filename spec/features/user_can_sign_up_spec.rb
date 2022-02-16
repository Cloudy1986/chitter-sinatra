feature 'Sign up' do
  scenario 'user can sign up' do
    visit '/sign-up'
    fill_in 'username', with: 'Dave MacDonald'
    fill_in 'email', with: 'dave@example.com'
    fill_in 'password', with: 'password123'
    click_button 'Sign up'

    expect(current_path).to eq '/peeps'
    expect(page).to have_content 'You are logged in as Dave MacDonald'
  end
end
