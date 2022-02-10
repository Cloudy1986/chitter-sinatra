# frozen_string_literal: true

feature 'View peeps' do
  scenario 'user can view a list of peeps' do
    Peep.create(message: 'Feature test peep 1')
    Peep.create(message: 'Feature test peep 2')
    Peep.create(message: 'Feature test peep 3')
    visit '/peeps'
    expect(page).to have_content 'Latest peeps'
    expect(page).to have_content 'Feature test peep 1'
    expect(page).to have_content 'Feature test peep 2'
    expect(page).to have_content 'Feature test peep 3'
  end
end
