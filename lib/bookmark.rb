require 'pg'
require 'uri'

class Bookmark

  attr_reader :id, :url, :name

  def initialize(id, url, name)
    @id = id
    @url = url
    @name = name
  end

  def self.all
    create_connection_to_database
    result = @connection.exec("SELECT * FROM bookmarks;")
    result.map do |bookmark|
      Bookmark.new(bookmark['id'], bookmark['url'], bookmark['name'])
    end
  end

  def self.create(url, name)
    return false unless valid_url?(url)
    create_connection_to_database
    @connection.exec("INSERT INTO bookmarks(url, name) VALUES ('#{url}', '#{name}');")
  end

  private

  def self.create_connection_to_database
    if ENV['RACK_ENV'] == 'test'
      db = 'bookmark_manager_test'
    else
      db = 'bookmark_manager'
    end
    @connection = PG.connect(dbname: db)
  end

  def self.valid_url?(url)
    url =~ /\A#{URI::regexp}\z/
  end

end
