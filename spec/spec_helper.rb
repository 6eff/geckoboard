# encoding: UTF-8

require 'bundler'

Bundler.setup
Bundler.require

ENV["RACK_ENV"] = "test"

require 'rack/test'
require 'capybara/rspec'
require 'sequel'
require 'database_cleaner'
require 'fakeredis'
REDIS = Redis.new
#Capybara.app = GeckoApp


require "find"
%w{./config/initializers ./lib}.each do |load_path|
  Find.find(load_path) { |f| require f if f.match(/\.rb$/) }
end

DatabaseCleaner[:sequel, {:connection => Sequel.connect("postgres://julia@localhost/gecko_app_test")}]

RSpec.configure do |config|

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

end
