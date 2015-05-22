require 'active_record'
require 'protected_attributes'
require 'bcrypt'

config = YAML.load(ERB.new(File.read('config/database.yml')).result).fetch(ENV['RACK'])
ActiveRecord::Base.establish_connection(config)
ActiveRecord::Base.logger = Logger.new(STDOUT)
ActiveRecord::Base.include_root_in_json = false
ActiveRecord::Base.default_timezone = :utc
