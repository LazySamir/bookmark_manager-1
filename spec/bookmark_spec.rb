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
    it 'adds a URL to the list of bookmarks' do
      Bookmark.create('http://www.yahoo.com', 'yahoo')
      bookmarks = Bookmark.all
      expect(bookmarks.first.name).to eq "yahoo"
    end
    it 'returns valid Bookmark object' do
      expect(Bookmark.create("http://www.google.com", "google")).to eq true
    end
  end
  describe 'when url is invalid' do
    it 'returns false' do
      expect(Bookmark.create("hi there", "hi")).to eq false
    end
  end
end
