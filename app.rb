$LOAD_PATH.unshift File.expand_path(File.dirname(__FILE__))

require 'boot'
require 'app/models'
require 'app/routes'
require 'app/extensions'

module DataStoreApi
  class App < Sinatra::Base
    configure do
      set :root, ENV['APP_ROOT']
      set :envronment, ENV['RACK_ENV']
      enable :logging
      enable :sessions
      set :session_secret, 'supersecret'
      Apartment::Tenant.init
    end

    configure :production, :staging do
    end

    def self.logger
      @@logger ||= Logger.new(File.join(ENV['APP_ROOT'],
                                        'log',
                                        "#{ENV['RACK_ENV']}.log"))
    end

    error Sinatra::NotFound do
      halt 404
    end

    Warden::Manager.before_failure do |env,opts|
      env['REQUEST_METHOD'] = 'POST'
    end

    register Extensions::Auth

    use Rack::CommonLogger
    use Routes::Health
    use Routes::V1::Uploads
  end
end
