feature 'Add comment' do
  scenario 'user can add a comment to a peep' do
    user = User.create(username: 'Bob', email: 'bob@example.com', password: 'password1234')
    peep = Peep.create(message: 'Test peep 2', user_id: user.id)
    visit '/log-in'
    fill_in 'email', with: 'bob@example.com'
    fill_in 'password', with: 'password1234'
    click_button 'Log in'
    click_button 'Add comment'
    expect(current_path).to eq "/peeps/#{peep.id}/comments/new"
    fill_in 'comment_text', with: 'This is a comment'
    click_button 'Add comment'
    expect(current_path).to eq "/peeps/#{peep.id}/comments"
    expect(page).to have_content 'This is a comment'
  end
end
