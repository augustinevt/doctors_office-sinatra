require 'rspec'
require 'pg'
require 'launchy'
require 'pry'
require 'doctor'
require 'patient'
require 'capybara/rspec'
require './app.rb'

Capybara.app = Sinatra::Application
set :show_exceptions, false

DB = PG.connect({dbname: 'doctors_office_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM doctors *;")
    DB.exec("DELETE FROM patients *;")
  end
end
