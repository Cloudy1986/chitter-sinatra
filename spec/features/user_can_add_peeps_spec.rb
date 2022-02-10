# frozen_string_literal: true

feature 'Add peeps' do
  scenario 'user can add a peep and it displays in the list of peeps' do
    visit '/peeps'
    click_button 'Add a new peep'
    fill_in 'message', with: 'This is a new peep'
    click_button 'Add peep'
    expect(current_path).to eq '/peeps'
    expect(page).to have_content 'Latest peeps'
    expect(page).to have_content 'This is a new peep'
  end
end
