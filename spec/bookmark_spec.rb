require 'pg'

describe '.all' do
  it 'returns a list of bookmarks' do
    connection = PG.connect(dbname: 'bookmark_manager_test')
    connection.exec("INSERT INTO bookmarks VALUES(1, 'http://www.makersacademy.com', 'makersacademy');")
    bookmarks = Bookmark.all
    expect(bookmarks.first.name).to eq "makersacademy"
  end
end

describe '.create' do
  describe 'when url is valid' do
    it 'it creates a new bookmark' do
      bookmark = Bookmark.create('http://www.yahoo.com', 'yahoo')
      expect(bookmark).to be_a Bookmark
      expect(bookmark.name).to eq "yahoo"
    end
  end
  describe 'when url is invalid' do
    it 'it returns false' do
      bookmark = Bookmark.create("hi there", "hi")
      expect(bookmark).to eq false
    end
  end
end
