module Routes
  class V1::Uploads < V1::Base
    get '/upload' do
      json({ status: 'ok', filesize: '10Mb' })
    end
  end
end
