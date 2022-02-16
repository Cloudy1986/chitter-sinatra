# frozen_string_literal: true

feature 'View peeps' do
  scenario 'user can view a list of peeps' do
    user = User.create(username: 'Bob', email: 'bob@example.com', password: 'password1234')
    Peep.create(message: 'Feature test peep 1', user_id: user.id)
    Peep.create(message: 'Feature test peep 2', user_id: user.id)
    Peep.create(message: 'Feature test peep 3', user_id: user.id)
    visit '/peeps'
    expect(page).to have_content 'Latest peeps'
    expect(page).to have_content 'Feature test peep 1'
    expect(page).to have_content 'Feature test peep 2'
    expect(page).to have_content 'Feature test peep 3'
  end

  scenario 'user can view when peep was created' do
    user = User.create(username: 'Bob', email: 'bob@example.com', password: 'password1234')
    Peep.create(message: 'Testing viewing created at', user_id: user.id)
    peep = Peep.all[0]
    visit '/peeps'
    expect(page).to have_content Time.parse(peep.created_at.to_s).strftime('%H:%M %d/%m/%Y')
  end

  scenario 'user can see who created each peep' do
    user = User.create(username: 'Mary', email: 'mary@example.com', password: '1234password')
    Peep.create(message: 'This is a peep by Mary', user_id: user.id)
    user2 = User.create(username: 'Dave', email: 'dave@example.com', password: 'password20')
    Peep.create(message: 'This is a peep by Dave', user_id: user2.id)
    visit '/peeps'
    expect(current_path).to eq '/peeps'
    expect(page).to have_content "Created by #{user.username}"
    expect(page).to have_content "Created by #{user2.username}"
  end
end
