module Routes
  class V1::Auth < V1::Base
    post '/auth/unauthenticated' do
      content_type :json
      status 401
      json({ message: 'Error HTTP 401 Unauthorized' })
    end

    post '/auth/login' do
      puts 'Authenticating'
      env['warden'].authenticate!
      json({ status: 'ok' })
    end

    get '/auth/logout' do
      env['warden'].raw_session.inspect
      env['warden'].logout
      json({ status: 'ok' })
    end
  end
end
