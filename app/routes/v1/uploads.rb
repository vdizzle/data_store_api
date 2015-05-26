module Routes
  class V1::Uploads < V1::Base
    post '/upload' do
      filename = json_params[:file][:filename]
      path = json_params[:file][:tempfile]
      file_sample = File.foreach(path).first(10)

      attributes = {
        filename: filename,
        content: File.read(path),
        size: File.size(path)
      }

      RawUpload.create!(attributes)
      File.delete(path)

      json({ status: 'ok', file_sample: file_sample })
    end
  end
end
