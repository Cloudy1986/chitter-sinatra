# frozen_string_literal: true

feature 'View comments' do
  scenario 'user can view comments for a peep, when they were created and who created each peep' do
    user = User.create(username: 'Bob', email: 'bob@example.com', password: 'password1234')
    peep = Peep.create(message: 'Test peep 2', user_id: user.id)
    comment = Comment.create(text: 'This is a comment', peep_id: peep.id, user_id: user.id)
    visit '/peeps'
    click_button 'View comments'
    expect(current_path).to eq "/peeps/#{peep.id}/comments"
    expect(page).to have_content 'This is a comment'
    expect(page).to have_content Time.parse(comment.created_at.to_s).strftime('%H:%M %d/%m/%Y')
    expect(page).to have_content "Created by #{user.username}"
  end
end
