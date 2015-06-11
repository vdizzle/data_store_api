require 'route_spec_helper'

describe 'Base Route Check', :request do
  include_context 'valid_api_user'
  let(:app) { Routes::V1::Base }

  shared_examples 'a successful request' do
    describe 'with proper and valid request headers' do
      it 'should be successful' do
        get '/v1-route-check', {}, request_headers(api_client.key,
                                                   api_user.id,
                                                   '1.0')
        result = parse_json(last_json)
        expect(last_response).to be_successful
        expect(result['status']).to match('ok')
      end
    end
  end

  describe 'API version check' do
    context 'with an invalid version' do
      it 'should respond with an error' do
        get '/v1-route-check', {}, request_headers(api_client.key,
                                                   api_user.id,
                                                   '5.0')
        result = parse_json(last_json)
        expect(last_response).not_to be_successful
        expect(result['errors'].first).to match(/^Invalid API version$/)
      end
    end

    context 'with a valid version' do
      it_behaves_like 'a successful request'
    end
  end

  describe 'Header check' do
    context 'without api key header' do
      it 'should respond with an error' do
        get '/v1-route-check', {}, user_header(api_user.id)

        result = parse_json(last_json)
        expect(last_response).not_to be_successful
        expect(
          result['errors'].first
        ).to match(/Missing Header: HTTP_X_DATA_STORE_API_KEY/)
      end
    end

    context 'without user header' do
      it 'should respond with an error' do
        get '/v1-route-check', {}, api_key_header(api_client.key)

        result = parse_json(last_json)
        expect(last_response).not_to be_successful
        expect(
          result['errors'].first
        ).to match(/Missing Header: HTTP_X_DATA_STORE_USER_ID/)
      end
    end

    context 'with api key header' do
      it_behaves_like 'a successful request'
    end
  end

  describe 'API Key check' do
    context 'with invalid API Key' do
      it 'should respond with an error' do
        get '/v1-route-check', {}, request_headers('junk', api_user.id)

        result = parse_json(last_json)
        expect(last_response).not_to be_successful
        expect(result['errors'].first).to match(/Not Authorized/)
      end
    end

    context 'with valid API Key' do
      it_behaves_like 'a successful request'
    end
  end

  describe 'User check' do
    context 'with invalid user' do
      it 'should respond with an error' do
        get '/v1-route-check', {}, request_headers(api_client.key, 666)

        result = parse_json(last_json)
        expect(last_response).not_to be_successful
        expect(result['errors'].first).to match(/Record Not Found/)
      end
    end

    context 'with valid API Key' do
      it_behaves_like 'a successful request'
    end
  end

  describe 'User schema check for a valid user' do
    let(:current_user_schema) { "user_schema_#{api_user.id}" }

    context 'without a user schema created' do
      before do
        Apartment::Tenant.drop(current_user_schema)
      end

      it 'should create and switch to the schema' do
        expect(Apartment::Tenant.current).to eq(current_user_schema)
      end
    end

    context 'with a user schema created' do
      it 'should switch to the schema' do
        expect(Apartment::Tenant.current).to eq(current_user_schema)
      end
    end
  end
end
