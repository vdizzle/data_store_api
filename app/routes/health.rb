module Routes
  class Health < Sinatra::Application
    get '/ha-check' do
      json({ status: 'ok' })
    end
  end
end
