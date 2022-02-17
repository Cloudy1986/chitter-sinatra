# frozen_string_literal: true

feature 'Delete peep' do
  scenario 'user can delete a peep' do
    user = User.create(username: 'Bob', email: 'bob@example.com', password: 'password1234')
    Peep.create(message: 'Test peep 2', user_id: user.id)
    visit '/peeps'
    expect(page).to have_content 'Test peep 2'
    click_button 'Delete peep'
    expect(current_path).to eq '/peeps'
    expect(page).to_not have_content 'Test peep 2'
  end
end
