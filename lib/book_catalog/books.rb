require 'json'

class Books
  BOOKS_PATH = File.expand_path('../data/books.json', __FILE__)

  def self.all
    JSON.parse(File.read(BOOKS_PATH))
  end
end
