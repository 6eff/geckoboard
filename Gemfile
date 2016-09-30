source "https://rubygems.org/"

# App Stack

# Database Stack
gem "sequel"
gem "pg"

# Redis
gem "hiredis"
gem "redis", :require => ["redis/connection/hiredis", "redis"]
gem "fakeredis"

group :development do
  gem "rake"
  gem "minitest"
  gem "rack-test"
end

group :test, :development do
  gem 'rspec'
  gem "rspec-sinatra"
  gem 'rack'
  gem 'sinatra'
  gem 'capybara'
end

gem "httparty"
gem "blockchain"
gem 'geckoboard-ruby'
gem "hazel"
