require 'pg'
require 'uri'

class Bookmark

  def self.all
    self.create_connection_to_database
    result = @connection.exec("SELECT * FROM bookmarks;")
    result.map { |bookmark| bookmark['name'] }
  end

  def self.create(url, name)
    if self.valid_url?(url)
      self.create_connection_to_database
      @connection.exec("INSERT INTO bookmarks(url, name) VALUES ('#{url}', '#{name}');")
      true
    else
      false
    end
  end

  def self.create_connection_to_database
    if ENV['RACK_ENV'] == 'test'
      db = 'bookmark_manager_test'
    else
      db = 'bookmark_manager'
    end
    @connection = PG.connect(dbname: db)
  end

private

  def self.valid_url?(url)
    return true if url =~ /\A#{URI::regexp}\z/
    return false
  end

end
