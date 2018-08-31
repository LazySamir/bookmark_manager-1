require_relative '../setup_test_database'

Capybara.app = BookmarkManager

feature 'Viewing bookmarks' do
  scenario 'user can see bookmarks' do
    insert_test_urls_into_database
    visit('/bookmarks')
    expect(page).to have_content "makersacademy"
    expect(page).to have_content "destroy"
    expect(page).to have_content "google"
  end
end

feature 'Adding bookmarks' do
  scenario 'user can see added bookmark in their index' do
    visit('/bookmarks/new')
    fill_in('bookmark_url', :with => "http://www.yahoo.com")
    fill_in('bookmark_name', :with => "yahoo")
    click_button('Submit')
    expect(page).to have_content "yahoo"
  end

  scenario 'returns a flash message if URL is invalid' do
    visit('/bookmarks/new')
    fill_in('bookmark_url', :with => "david&samir are awesome")
    click_button('Submit')
    expect(page).to have_content("Invalid URL")
  end
end

feature 'Deleting bookmarks' do
  scenario 'user can delete a bookmark' do
    Bookmark.create("https://www.reddit.com", 'reddit')
    Bookmark.create("https://www.instagram.com", 'instagram')

    visit 'bookmarks'
    first('.bookmark').click_button 'Delete'

    expect(page).not_to have_content 'reddit'
    expect(page).to have_content 'instagram'
  end
end

feature 'Updating bookmarks' do
  scenario 'user can update a bookmark' do
    Bookmark.create("https://www.reddit.com", 'reddit')

    visit 'bookmarks'
    first('.bookmark').click_button 'Edit'
    fill_in('url', :with => 'http://www.feddit.com')
    fill_in('name', :with => 'Feddit')
    click_button 'submit'

    expect(page).to have_content 'feddit'
    expect(page).not_to have_content 'reddit'
  end
end
