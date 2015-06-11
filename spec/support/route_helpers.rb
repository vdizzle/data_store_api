module RouteHelpers
  def last_json
    last_response.body
  end

  def request_headers(api_key, user_id, version = '1.0')
    {
      'Accept' => 'application/json',
      'Context-Type' => 'application/json',
      'HTTP_X_DATA_STORE_API_KEY' => api_key,
      'HTTP_X_DATA_STORE_USER_ID' => user_id,
      'HTTP_ACCEPT' => "application/vnd.custom_audience-v#{version}+json"
    }
  end

  def api_key_header(api_key, version = '1.0')
    {
      'Accept' => 'application/json',
      'Context-Type' => 'application/json',
      'HTTP_X_DATA_STORE_API_KEY' => api_key,
      'HTTP_ACCEPT' => "application/vnd.custom_audience-v#{version}+json"
    }
  end

  def user_header(user_id, version = '1.0')
    {
      'Accept' => 'application/json',
      'Context-Type' => 'application/json',
      'HTTP_X_DATA_STORE_USER_ID' => user_id,
      'HTTP_ACCEPT' => "application/vnd.custom_audience-v#{version}+json"
    }
  end
end
