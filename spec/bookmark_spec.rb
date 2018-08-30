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
    Bookmark.create('http://www.yahoo.com')
    expect(Bookmark.all).to include "http://www.yahoo.com"
  end
end

describe '.valid_url?' do
  it 'returns false if URL is invalid' do
    expect(Bookmark.valid_url?("hi there")).to eq false
  end

  it 'returns true if URL is valid' do
    expect(Bookmark.valid_url?("http://www.google.com")).to eq true
  end
end
