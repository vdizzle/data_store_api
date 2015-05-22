module Extensions
  module Auth
    module Helpers
      def current_user
        if signed_in?
        end
      end

      def signed_in?
        session['warden.user.default.key']
      end

      def session_id
        session.id if session.respond_to?(:id)
      end
    end

    def self.registered(app)
      app.helpers Auth::Helpers

      app.use Warden::Manager do |config|
        config.serialize_into_session { |user| user.id }
        config.serialize_from_session { |id| User.find(id) }
        config.scope_defaults :default,
          strategies: [:password],
          action: 'auth/unauthenticated'
        config.failure_app = self
      end

      app.post '/auth/unauthenticated' do
        content_type :json
        status 401
        json({ message: 'Error HTTP 401 Unauthorized' })
      end

      app.post '/auth/login' do
        env['warden'].authenticate!
        puts session.inspect
        json({ status: 'ok' })
      end

      app.get '/auth/logout' do
        env['warden'].raw_session.inspect
        env['warden'].logout
        puts session.inspect
        json({ status: 'ok' })
      end
    end
  end
end
