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
