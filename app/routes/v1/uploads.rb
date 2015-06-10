require 'base64'

module Routes
  class V1::Uploads < V1::Base
    post '/upload' do
      attributes = {
        filename: attachment[:filename],
        content: file_content,
        size: attachment[:size]
      }

      upload = RawUpload.create!(attributes)

      json({ status: 'ok', upload_id: upload.id, file_sample: file_sample })
    end

    private
    attr_reader :attachment, :file_content

    def attachment
      json_params[:attachment]
    end

    def file_content
      @file_content ||= Base64.decode64(
        attachment[:content]['data:text/csv;base64,'.length .. -1])
    end

    def file_sample
      lines = []
      head = 0
      tail = 0
      while lines.count < 20
        if lines.count == 0
          head = 0
        else
          head = tail + "\n".length
        end
        tail = file_content.index("\r\n", head + 1) + "\n".length
        lines << file_content[head..tail]
      end
      lines
    end
  end
end
