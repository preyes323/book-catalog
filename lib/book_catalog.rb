require 'grape'
require_relative 'book_catalog/books'

class BookCatalog < Grape::API
  helpers do
    def declared_params
      declared(params, include_missing: false)
    end
  end

  rescue_from Grape::Exceptions::ValidationErrors do |e|
    message = e.message.gsub(/\s*\[.*\Z/, '')
    rack_response({ status_code: 422, message: message.capitalize }.to_json, 422)
  end

  group do
    before do
      content_type 'application/json'
    end

    desc "Fetch all books."
    get '/books' do
      Books.all
    end

    desc "Create a new book entry."
    params do
      requires :title, type: String, desc: 'Title of the book'
      requires :author, type: String, regexp: /^[A-Za-z ]+$/, desc: 'Name of the author'
    end
    post '/books' do
      declared_params
    end
  end

  desc "Fetch invalid json."
  get '/invalid_book' do
    content_type 'text/plain'
    body '{ title: "JavaScript: The Good Parts", author: "Douglas Crockford" }'
  end
end
