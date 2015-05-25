require 'apartment'

Apartment.configure do |config|
  config.use_schemas = true
  config.database_schema_file = File.join(ENV['APP_ROOT'], 'db/schema.rb')
  config.excluded_models = ['ApiKey', 'User']
end
