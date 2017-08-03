source 'https://rubygems.org'

ruby '2.3.3'

gem 'rack'
gem 'grape'
gem 'rake'

gem 'rack-cors', :require => 'rack/cors'

gem 'racksh'
gem 'grape-swagger'
gem 'hashie-forbidden_attributes'

group :development do
  gem 'byebug'
  gem 'rerun'
end

group :development, :production do
  gem 'shotgun'
end

group :test do
  gem 'rspec'
  gem 'rack-test', require: 'rack/test'
end

group :production do
  gem 'thin'
end
