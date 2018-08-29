require 'pg'

class Bookmark

  def self.all
    self.connect_to_database
    connection = PG.connect(dbname: @db)
    result = connection.exec("SELECT * FROM bookmarks;")
    result.map { |bookmark| bookmark['url'] }
  end

  def self.connect_to_database
    if ENV['RACK_ENV'] == 'test'
      @db = 'bookmark_manager_test'
    else
      @db = 'bookmark_manager'
    end
  end

end
