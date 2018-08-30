require_relative '../setup_test_database'

Capybara.app = BookmarkManager

feature 'Viewing bookmarks' do
  scenario 'user can see bookmarks' do
    insert_test_urls_into_database
    visit('/bookmarks')
    expect(page).to have_content "http://www.makersacademy.com"
    expect(page).to have_content "http://www.destroyallsoftware.com"
    expect(page).to have_content "http://www.google.com"
  end
end

feature 'Adding bookmarks' do
  scenario 'user can see added bookmark in their index' do
    visit('/bookmarks/new')
    fill_in('bookmark_url', :with => "http://www.yahoo.com")
    click_button('Submit')
    expect(page).to have_content "http://www.yahoo.com"
  end

  scenario 'returns a flash message if URL is invalid' do
    visit('/bookmarks/new')
    fill_in('bookmark_url', :with => "david&samir are awesome")
    click_button('Submit')
    expect(page).to have_content("Invalid URL")
  end
end
