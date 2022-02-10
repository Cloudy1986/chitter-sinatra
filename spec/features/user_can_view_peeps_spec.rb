# frozen_string_literal: true

feature 'View peeps' do
  scenario 'user can view a list of peeps' do
    connection = PG.connect(dbname: 'chitter_sinatra_test')
    connection.exec_params('INSERT INTO peeps (message) VALUES ($1);', ['Feature test peep 1'])
    connection.exec_params('INSERT INTO peeps (message) VALUES ($1);', ['Feature test peep 2'])
    connection.exec_params('INSERT INTO peeps (message) VALUES ($1);', ['Feature test peep 3'])
    visit '/peeps'
    expect(page).to have_content 'Latest peeps'
    expect(page).to have_content 'Feature test peep 1'
    expect(page).to have_content 'Feature test peep 2'
    expect(page).to have_content 'Feature test peep 3'
  end
end
