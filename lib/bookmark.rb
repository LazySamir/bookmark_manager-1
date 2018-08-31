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
    result = @connection.exec("INSERT INTO bookmarks(url, name) VALUES ('#{url}', '#{name}') RETURNING id, url, name;")
    # the above means you don't need to supply an id when creating a new bookmark
    Bookmark.new(result[0]['id'], result[0]['url'], result[0]['name'])
  end

  def self.delete(target_id)
    create_connection_to_database
    @connection.exec("DELETE FROM bookmarks WHERE id = '#{target_id}'")
  end

  def self.search_by_id(id)
    create_connection_to_database

  end

  private

  def self.create_connection_to_database
    ENV['RACK_ENV'] == 'test' ? (db = 'bookmark_manager_test') : (db = 'bookmark_manager')
    @connection = PG.connect(dbname: db)
    # change so doesnt save an instance variables
  end

  def self.valid_url?(url)
    url =~ /\A#{URI::regexp}\z/
  end

end
