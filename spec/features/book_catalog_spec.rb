require 'rack/test'
require_relative '../../lib/book_catalog'
require_relative '../../lib/book_catalog/books.rb'

RSpec.describe BookCatalog do
  include Rack::Test::Methods

  def app
    BookCatalog
  end

  context 'GET /books' do
    it 'returns a json response with three books' do
      get '/books'
      expect(last_response.status).to eq(200)
      expect(JSON.parse(last_response.body)).to eq(Books.all)
    end
  end

  context 'POST /books' do
    let(:book) { {"title" => 'Hyperion', "author" => 'Dan Simmons'} }
    let(:book_with_extra_params) { book.merge({"price" => 14}) }
    let(:invalid_book) { {"title" => 'Hyperion'} }
    let(:invalid_json) {}

    it 'returns the sent params as json' do
      post '/books', book
      expect(last_response.status).to eq(201)
      expect(JSON.parse(last_response.body)).to eq(book)
    end

    it 'ignores params other than :title, and :author' do
      post '/books', book_with_extra_params
      expect(last_response.status).to eq(201)
      expect(JSON.parse(last_response.body)).to eq(book)
    end

    it 'returns a 422 response with invalid params' do
      post '/books', invalid_book
      expect(last_response.status).to eq(422)
    end
  end

  context 'GET /invalid_book' do
    it 'returns an invalid JSON response' do
      get '/invalid_book'
      expect { JSON.parse(last_response.body) }.to raise_error(JSON::ParserError)
    end
  end
end
