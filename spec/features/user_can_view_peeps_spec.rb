feature 'View peeps' do
  scenario 'user can view a list of peeps' do
    visit '/peeps'
    expect(page).to have_content 'Latest peeps'
    expect(page).to have_content "I'm learning to code and practising building a web app"
    expect(page).to have_content "Ruby is the best!"
    expect(page).to have_content "I'm loving using Sinatra to build a web app"
  end
end
