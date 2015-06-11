require 'spec_helper'
require 'rack/test'
require 'json_spec'

Dir[File.join(ENV['APP_ROOT'], 'spec/support/*.rb')].each { |f| require f }

RSpec.configure do |config|
  config.include Rack::Test::Methods, :request => true
  config.include JsonSpec::Helpers, :request => true
  config.include RouteHelpers, :request => true
end
