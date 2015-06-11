module Routes
  class V1::Base < Sinatra::Application
    DEFAULT_API_VERSION = '1.0'

    helpers Sinatra::JSON

    configure do
      set :json_encoder, :to_json
      set :views, File.join(ENV['APP_ROOT'], 'app/views/v1')
      set :show_exceptions, false
      set :raise_errors, false
    end

    before do
      pass if %w(auth).include? request.path_info.split('/')[1]

      bad_request! 'Invalid API version' unless requested_api_version =~ /^1(\.?\d?)*/
      assert_header! 'HTTP_X_DATA_STORE_API_KEY', 'HTTP_X_DATA_STORE_USER_ID'
      validate_api_client!
      set_user_schema!
    end

    error Sinatra::NotFound do
      halt 404
    end

    error ActiveRecord::RecordNotFound do
      halt(404, { errors: ['Record Not Found!'] }.to_json)
    end

    configure :test do
      get '/v1-route-check' do
        json({ status: 'ok' })
      end
    end

    protected

    def current_client
      @current_client ||= ApiKey.find_by_key(env['HTTP_X_DATA_STORE_API_KEY'])
    end

    def current_api_user_id
      assert_header! 'HTTP_X_DATA_STORE_USER_ID'
      user_id = request.env['HTTP_X_DATA_STORE_USER_ID']
      User.find(user_id).id
    end

    def set_user_schema!
      user_schema = "user_schema_#{current_api_user_id}"
      begin
        Apartment::Tenant.switch!(user_schema)
      rescue Apartment::TenantNotFound
        Apartment::Tenant.create(user_schema)
        Apartment::Tenant.switch!(user_schema)
      end
    end

    def validate_api_client!
      not_authorized! and return unless current_client
    end

    def requested_api_version
      request.env['HTTP_ACCEPT'].to_s[/.*\-v(\d+(?:\.\d+)*)/, 1] ||
        DEFAULT_API_VERSION
    end

    def bad_request!(error = nil)
      halt 400, { errors: [error || 'Bad Request!'] }.to_json
    end

    def not_authorized!
      halt 403, { errors: ['Not Authorized!'] }.to_json
    end

    def assert_header!(*headers)
      headers.each do |header|
        bad_request! "Missing Header: #{header}" if env[header].blank?
      end
    end

    def json_params
      begin
        @json_body ||= JSON.parse(request.body.read).deep_symbolize_keys
      rescue JSON::ParserError
        bad_request! I18n.t('errors.parse_error')
      end
      @json_body
    end
  end
end
