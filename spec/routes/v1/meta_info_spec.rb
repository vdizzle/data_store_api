require 'route_spec_helper'

describe 'Meta Info Route', :request do
  include_context 'valid_api_user'

  let(:app) { Routes::V1::MetaInfo }

  describe 'GET /meta-info/data-types' do
    before do
      get '/meta-info/data-types', {}, request_headers(api_client.key, api_user.id)
    end

    it 'should be successful' do
      expect(last_response).to be_successful
    end

    it 'should return proper JSON structure' do
      expect(last_json).to have_json_size(20)
      expect(last_json).to have_json_path('0/code')
      expect(last_json).to have_json_path('0/title')
      expect(last_json).to have_json_path('0/data_type')
    end
  end
end
