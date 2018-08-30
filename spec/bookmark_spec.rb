require 'pg'

describe '.all' do
  it 'returns a list of bookmarks' do
    insert_test_urls_into_database
    bookmarks = Bookmark.all
    expect(bookmarks).to include "makersacademy"
  end
end

describe '.create' do
  describe 'when url is valid' do
    it 'adds a URL to the list of bookmarks' do
      Bookmark.create('http://www.yahoo.com', 'yahoo')
      expect(Bookmark.all).to include "yahoo"
    end
    it 'returns true' do
      expect(Bookmark.create("http://www.google.com", "google")).to eq true
    end
  end
  describe 'when url is invalid?' do
    it 'returns false' do
      expect(Bookmark.create("hi there", "hi")).to eq false
    end
  end
end
