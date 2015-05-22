module Extensions
  module Warden
    module Helpers
      def warden
        env['warden']
      end

      def authenticate_user
        warden.authenticate!(:bearer)
      end
    end

    def self.registered(app)
      app.helpers Warden::Helpers

      app.use Warden::Manager do |config|
        # Tell Warden how to save our User info into a session.
        # Sessions can only take strings, not Ruby code, we'll store
        # the User's `id`
        config.serialize_into_session{|user| user.id }
        # Now tell Warden how to take what we've stored in the session
        # and get a User from that information.
        config.serialize_from_session{|id| User.get(id) }

        config.scope_defaults :default,
          # "strategies" is an array of named methods with which to
          # attempt authentication. We have to define this later.
          strategies: [:password],
          # The action is a route to send the user to when
          # warden.authenticate! returns a false answer. We'll show
          # this route below.
          action: 'auth/unauthenticated'
        # When a user tries to log in and cannot, this specifies the
        # app to send the user to.
        config.failure_app = self
      end

      app.post '/auth/unauthenticated' do
        content_type :json
        status 401
        json({ message: "Error HTTP 401 Unauthorized" })
      end

      app.post '/auth/login' do
        env['warden'].authenticate!
        true
      end

      app.get '/auth/logout' do
        env['warden'].raw_session.inspect
        env['warden'].logout
        true
      end
    end
  end

  register Warden
end
