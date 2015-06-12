require 'route_spec_helper'

describe 'Uploads Route', :request do
  include_context 'valid_api_user'
  let(:app) { Routes::V1::Uploads }

  describe 'GET /uploads' do
    before do
      create_list(:raw_upload, 2)
      get '/uploads', {}, request_headers(api_client.key, api_user.id)
    end

    it 'should be successful' do
      expect(last_response).to be_successful
    end

    it 'should return proper JSON structure' do
      expect(last_json).to have_json_size(2)
      expect(last_json).to have_json_path('0/id')
      expect(last_json).to have_json_path('0/filename')
      expect(last_json).to have_json_path('0/filetype')
      expect(last_json).to have_json_path('0/line_count')
      expect(last_json).to have_json_path('0/size')
      expect(last_json).to have_json_path('0/sample')
      expect(last_json).to have_json_path('0/table_name')
      expect(last_json).to have_json_path('0/meta_info')
    end

    it 'should return proper JSON data' do
      result = parse_json(last_json).last
      upload = RawUpload.last

      expect(result['id']).to eq(upload.id)
      expect(result['filename']).to eq(upload.filename)
      expect(result['filetype']).to eq(upload.filetype)
      expect(result['line_count']).to eq(upload.line_count)
      expect(result['size']).to eq(upload.size)
      expect(result['sample']).to eq(upload.sample)
      expect(result['table_name']).to eq(upload.table_name)
      expect(result['meta_info']).to eq(upload.meta_info)
    end
  end

  describe 'GET /uploads/:id' do
    let(:upload) { create(:raw_upload) }
    before do
      get "/uploads/#{upload.id}", {}, request_headers(api_client.key,
                                                       api_user.id)
    end

    it 'should be successful' do
      expect(last_response).to be_successful
    end

    it 'should return proper JSON structure' do
      expect(last_json).to have_json_size(8)
      expect(last_json).to have_json_path('id')
      expect(last_json).to have_json_path('filename')
      expect(last_json).to have_json_path('filetype')
      expect(last_json).to have_json_path('line_count')
      expect(last_json).to have_json_path('size')
      expect(last_json).to have_json_path('sample')
      expect(last_json).to have_json_path('table_name')
      expect(last_json).to have_json_path('meta_info')
    end

    it 'should return proper JSON data' do
      result = parse_json(last_json)

      expect(result['id']).to eq(upload.id)
      expect(result['filename']).to eq(upload.filename)
      expect(result['filetype']).to eq(upload.filetype)
      expect(result['line_count']).to eq(upload.line_count)
      expect(result['size']).to eq(upload.size)
      expect(result['sample']).to eq(upload.sample)
      expect(result['table_name']).to eq(upload.table_name)
      expect(result['meta_info']).to eq(upload.meta_info)
    end
  end

  describe 'POST /uploads' do
    let(:csv_content) do
      """Name,Email,Address
      Winston Churchill, wc@gmail.com, awesome
      Adolf Hitler, ah@gmail.com, hell"""
    end

    let(:payload) do
      {
        attachment: {
          filename: 'user-info.csv',
          filetype: 'text/csv',
          content: 'data:text/csv;base64,'.concat(Base64.encode64(csv_content)),
          size: '963'
        }
      }
    end

    before do
      post '/uploads', payload.to_json, request_headers(api_client.key,
                                                        api_user.id)
    end

    it 'should be successful' do
      expect(last_response).to be_successful
    end

    it 'should return proper JSON structure' do
      expect(last_json).to have_json_size(8)
      expect(last_json).to have_json_path('id')
      expect(last_json).to have_json_path('filename')
      expect(last_json).to have_json_path('filetype')
      expect(last_json).to have_json_path('line_count')
      expect(last_json).to have_json_path('size')
      expect(last_json).to have_json_path('sample')
      expect(last_json).to have_json_path('table_name')
      expect(last_json).to have_json_path('meta_info')
    end

    it 'should return proper JSON data' do
      result = parse_json(last_json)
      upload = RawUpload.last

      expect(result['id']).to eq(upload.id)
      expect(result['filename']).to eq(upload.filename)
      expect(result['filetype']).to eq(upload.filetype)
      expect(result['line_count']).to eq(upload.line_count)
      expect(result['size']).to eq(upload.size)
      expect(result['sample']).to eq(upload.sample)
      expect(result['table_name']).to eq(upload.table_name)
      expect(result['meta_info']).to eq(upload.meta_info)
    end
  end

  describe 'DELETE /uploads/:id' do
    let(:upload) { create(:raw_upload) }
    before do
      delete "/uploads/#{upload.id}", {}, request_headers(api_client.key,
                                                       api_user.id)
    end

    it 'should be successful' do
      expect(last_response).to be_successful
      result = parse_json(last_json)
      expect(result['status']).to eq('ok')
    end
  end
end
