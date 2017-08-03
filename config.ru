require 'rack/cors'
require_relative 'lib/book_catalog'

use Rack::Cors do
  allow do
    origins '*'
    resource '*', headers: :any, methods: [:get, :post, :patch, :options]
  end
end

run BookCatalog
