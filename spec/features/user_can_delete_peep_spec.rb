# frozen_string_literal: true

feature 'Delete a peep' do
  scenario 'user can delete a peep that belongs to them' do
    user = User.create(username: 'Bob', email: 'bob@example.com', password: 'password1234')
    Peep.create(message: 'Test peep 2', user_id: user.id)
    visit '/log-in'
    fill_in 'email', with: 'bob@example.com'
    fill_in 'password', with: 'password1234'
    click_button 'Log in'
    expect(page).to have_content 'Test peep 2'
    click_button 'Delete peep'
    expect(current_path).to eq '/peeps'
    expect(page).to_not have_content 'Test peep 2'
  end

  scenario 'user cannot delete a peep that belongs to a different user' do
    user = User.create(username: 'Bob', email: 'bob@example.com', password: 'password1234')
    Peep.create(message: 'Bob peep', user_id: user.id)
    logged_in_user = User.create(username: 'Mary', email: 'mary@example.com', password: '1234password')
    visit '/log-in'
    fill_in 'email', with: 'mary@example.com'
    fill_in 'password', with: '1234password'
    click_button 'Log in'
    expect(current_path).to eq '/peeps'
    expect(page).to have_content 'Bob peep'
    expect(page).to_not have_button 'Delete peep'
  end
end
