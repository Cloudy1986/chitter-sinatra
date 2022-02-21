feature 'View comments' do
  scenario 'user can view comments for a peep' do
    user = User.create(username: 'Bob', email: 'bob@example.com', password: 'password1234')
    peep = Peep.create(message: 'Test peep 2', user_id: user.id)
    Comment.create(text: 'This is a comment', peep_id: peep.id, user_id: user.id)
    visit '/peeps'
    click_button 'View comments'
    expect(current_path).to eq "/peeps/#{peep.id}/comments"
    expect(page).to have_content 'This is a comment'
  end
end