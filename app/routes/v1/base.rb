module Routes
  class V1::Base < Sinatra::Application
    DEFAULT_API_VERSION = '1.0'

    helpers Sinatra::JSON

    configure do
      set :json_encoder, :to_json
      set :views, File.join(ENV['APP_ROOT'], 'app/views')
      set :show_exceptions, false
      set :raise_errors, false
    end

    before do
      bad_request! 'Invalid API version' unless requested_api_version =~ /^1(\.?\d?)*/
      assert_header! 'HTTP_X_DATA_STORE_API_KEY'
      validate_api_client!
    end

    error Sinatra::NotFound do
      halt 404
    end

    protected

    def current_client
      @current_client ||= ApiKey.find_by_key(env['HTTP_X_DATA_STORE_API_KEY'])
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
        bad_request! "Invalid Header : #{header}" if env[header].blank?
      end
    end
  end
end
