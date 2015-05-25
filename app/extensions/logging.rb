module Extensions
  module Logging
    def self.registered(app)
      app.enable :logging

      file = Logger.new(File.join(app.settings.root,
                                  'log',
                                  "#{app.settings.environment}.log"));
      app.set :log_file, file
      app.use Rack::CommonLogger, file

      app.before do
        env['rack.errors'] = app.settings.log_file
      end
    end
  end
end
