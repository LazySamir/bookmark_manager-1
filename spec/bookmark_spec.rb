require 'pg'

describe '.all' do
  it 'returns a list of bookmarks' do
    insert_test_urls_into_database
    bookmarks = Bookmark.all
    expect(bookmarks).to include "http://www.makersacademy.com"
  end
end

describe '.create' do
  describe 'when url is valid' do
    it 'adds a URL to the list of bookmarks' do
      Bookmark.create('http://www.yahoo.com')
      expect(Bookmark.all).to include "http://www.yahoo.com"
    end
    it 'returns true' do
      expect(Bookmark.create("http://www.google.com")).to eq true
    end
  end
  describe 'when url is invalid?' do
    it 'returns false' do
      expect(Bookmark.create("hi there")).to eq false
    end
  end
end
