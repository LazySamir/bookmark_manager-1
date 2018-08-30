require 'pg'

def setup_test_database
  connection = PG.connect(dbname: 'bookmark_manager_test')
  connection.exec("TRUNCATE bookmarks;")
end

def insert_test_urls_into_database
  connection = PG.connect(dbname: 'bookmark_manager_test')

  connection.exec("INSERT INTO bookmarks VALUES(1, 'http://www.makersacademy.com', 'makersacademy');")
  connection.exec("INSERT INTO bookmarks VALUES(2, 'http://www.destroyallsoftware.com', 'destroy');")
  connection.exec("INSERT INTO bookmarks VALUES(3, 'http://www.google.com', 'google');")
end
