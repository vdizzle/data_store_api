$LOAD_PATH.unshift File.expand_path(File.dirname(__FILE__))

require 'boot'
require 'app/models'
require 'app/routes'

module DataStoreApi
  class App < Sinatra::Base
    set :root, File.dirname(__FILE__)

    configure :production, :staging do
    end

    error Sinatra::NotFound do
      halt 404
    end

    configure do
      set :root, ENV['APP_ROOT']
      set :envronment, ENV['RACK']
    end

    Apartment::Tenant.init

    use Routes::Health
    use Routes::V1::Uploads
  end
end
