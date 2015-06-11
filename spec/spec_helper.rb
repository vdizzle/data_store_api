ENV['RACK_ENV'] = 'test'

require './app'

require 'database_cleaner'
require 'debugger'
require 'pry-debugger'
require 'erb'
require 'factory_girl'
require 'shoulda-matchers'
require 'simplecov' if ENV['COVERAGE']
require 'yaml'

Dir[File.join(ENV['APP_ROOT'], 'spec/factories/*.rb')].each { |f| require f }

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
    DatabaseCleaner.strategy = :transaction
  end

  config.before do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.start
  end

  config.after do
    DatabaseCleaner.clean
  end

  config.raise_errors_for_deprecations!

  config.mock_with :rspec do |mocks|
    mocks.verify_doubled_constant_names = true
  end
end
