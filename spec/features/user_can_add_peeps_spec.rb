# frozen_string_literal: true

feature 'Add peeps' do
  scenario 'user can add a peep and it displays in the list of peeps' do
    visit '/sign-up'
    fill_in 'username', with: 'Dave MacDonald'
    fill_in 'email', with: 'dave@example.com'
    fill_in 'password', with: 'password123'
    click_button 'Sign up'
    click_link 'Add a new peep'
    fill_in 'message', with: 'This is a new peep'
    click_button 'Add peep'
    expect(current_path).to eq '/peeps'
    expect(page).to have_content 'Latest peeps'
    expect(page).to have_content 'This is a new peep'
  end
end
