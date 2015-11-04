require 'uri'
require 'net/http'
require 'net/https'

module Instamojo
  # Manage sync call between instamojo
  class API
    attr_accessor :config, :access_token, :refresh_token, :header

    TEST_URL = 'https://test.instamojo.com'
    LIVE_URL = 'https://instamojo.com'

    def initialize(config = Instamojo.configuration)
      @config = config
      @header = true
    end

    def auth_token
      @access_token = nil
      token(credentials('client_credentials'))
    end

    def refresh_token
      token(credentials('refresh_token').merge(refresh_token: @refresh_token))
    end

    def signup(options = {})
      auth_token unless @access_token
      @header = true
      signup_url = "#{url}/v2/users/"
      post(signup_url, options)
    end

    def user_token(options = {})
      token(options.merge!(credentials('password')))
    end

    def inrbanckaccount(user_id, options = {})
      @header = true
      bank_url = "#{url}/v2/users/#{user_id}/inrbankaccount/"
      post(bank_url, options)
    end

    private

    def token(options)
      @header = false
      auth_url = "#{url}/oauth2/token/"
      response = post(auth_url, options)
      @access_token = response['access_token']
      @refresh_token = response['refresh_token']
      response
    end

    def credentials(grant_type)
      {
        grant_type: grant_type,
        client_id: config.client_id,
        client_secret: config.client_secret
      }
    end

    def url
      config.mode == :test ? TEST_URL : LIVE_URL
    end

    def post(url, options = {})
      uri = URI(url)
      req = Net::HTTP::Post.new(uri.path)
      headers.each do |key, value|
        req[key] = value
      end
      req.set_form_data(options)
      response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
        http.request(req)
      end
      JSON.parse(URI.decode(response.body))
    end

    def headers
      http_header = {
        'Content-Type' => 'application/x-www-form-urlencoded',
        'Accept' => 'application/json'
      }
      return http_header unless header || @access_token
      http_header.merge('Authorization' => "Bearer #{@access_token}")
    end
  end
end
