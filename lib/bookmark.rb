require 'pg'

class Bookmark

  def self.all
    self.determine_database
    connection = PG.connect(dbname: @db)
    result = connection.exec("SELECT * FROM bookmarks;")
    result.map { |bookmark| bookmark['url'] }
  end

  def self.create(url)
    self.determine_database
    connection = PG.connect(dbname: @db)
    connection.exec("INSERT INTO bookmarks(url) VALUES (\'#{url}\');")
  end

  def self.determine_database
    if ENV['RACK_ENV'] == 'test'
      @db = 'bookmark_manager_test'
    else
      @db = 'bookmark_manager'
    end
  end



end
