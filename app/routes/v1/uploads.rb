require 'base64'

module Routes
  class V1::Uploads < V1::Base
    get '/uploads' do
      @uploads = RawUpload.all
      jbuilder :'uploads/index'
    end

    get '/uploads/:id' do
      @upload = RawUpload.find(params[:id])
      jbuilder :'uploads/show'
    end

    post '/uploads' do
      encoded = attachment[:content]['data:text/csv;base64,'.length .. -1]
      content = Base64.decode64(encoded)
      attributes = {
        filename: attachment[:filename],
        filetype: attachment[:filetype],
        content: content,
        line_count: content.lines.count,
        size: attachment[:size]
      }

      @upload = RawUpload.create!(attributes)
      jbuilder :'uploads/create'
    end

    delete '/uploads/:id' do
      content_type :json
      RawUpload.find(params[:id]).destroy
      json({ status: 'ok' })
    end

    private
    attr_reader :attachment, :file_content

    def attachment
      json_params[:attachment]
    end
  end
end
