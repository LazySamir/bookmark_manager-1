require 'pg'

describe '.all' do
  it 'returns a list of bookmarks' do
    insert_test_urls_into_database
    bookmarks = Bookmark.all
    expect(bookmarks).to include "http://www.makersacademy.com"
  end
end
