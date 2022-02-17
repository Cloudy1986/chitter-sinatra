feature 'Edit peep' do
  scenario 'user can edit a peep' do
    user = User.create(username: 'Mary', email: 'mary@example.com', password: '1234password')
    Peep.create(message: 'This is a test peep', user_id: user.id)
    visit '/log-in'
    fill_in 'email', with: 'mary@example.com'
    fill_in 'password', with: '1234password'
    click_button 'Log in'
    click_button 'Edit peep'
    fill_in 'message', with: 'This peep has been edited'
    click_button 'Update peep'
    expect(current_path).to eq '/peeps'
    expect(page).to have_content 'This peep has been edited'
  end
end
