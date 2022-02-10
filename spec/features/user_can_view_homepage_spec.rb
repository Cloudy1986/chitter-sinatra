# frozen_string_literal: true

feature 'View homepage' do
  scenario 'user can view homepage' do
    visit '/'
    expect(page).to have_content 'Welcome to Chitter'
  end
end
