$LOAD_PATH.unshift File.expand_path(File.dirname(__FILE__))

require 'boot'
require 'app/models'
require 'app/routes'
require 'app/extensions'

module DataStoreApi
  class App < Sinatra::Base
    configure :production, :staging do
    end

    error Sinatra::NotFound do
      halt 404
    end

    configure do
      set :root, ENV['APP_ROOT']
      set :envronment, ENV['RACK']
      Apartment::Tenant.init
    end

    Warden::Manager.before_failure do |env,opts|
      env['REQUEST_METHOD'] = 'POST'
    end

    register Extensions::Auth

    use Routes::Health
    use Routes::V1::Uploads
  end
end
