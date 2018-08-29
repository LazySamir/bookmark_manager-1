require 'pg'

describe '.all' do
  it 'returns a list of bookmarks' do
    insert_test_urls_into_database
    bookmarks = Bookmark.all
    expect(bookmarks).to include "http://www.makersacademy.com"
  end
end

describe '.create' do
  it 'adds a URL to the list of bookmarks' do
    connection = PG.connect(dbname: 'bookmark_manager_test')
    connection.exec("INSERT INTO bookmarks(url) VALUES('http://www.yahoo.com');")
    expect(Bookmark.all).to include "http://www.yahoo.com"
  end
end
