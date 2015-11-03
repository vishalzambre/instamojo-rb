require 'uri'
require 'net/http'
require 'net/https'

module Instamojo
  # Manage sync call between instamojo
  class API
    attr_accessor :config, :access_token, :refresh_token

    TEST_URL = 'https://test.instamojo.com'
    LIVE_URL = 'https://instamojo.com'

    def initialize(config = Instamojo.configuration)
      @config = config
    end

    def auth_token
      token(credentials('client_credentials'))
    end

    def signup(options = {})
      auth_token
      options.require(:username, :password, :email, :phone)
      signup_url = "#{url}/v2/users/"
      post(signup_url, options)
    end

    def user_token(options = {})
      options.require(:username, :password)
      token(options.merge!(credentials('password')))
    end

    def inrbanckaccount(user_id, options = {})
      options.require(:account_holder_name, :account_number, :ifsc_code)
      bank_url = "#{url}/v2/users/#{user_id}/inrbankaccount"
      post(bank_url, options)
    end

    private

    def token(options)
      auth_url = "#{url}/oauth2/token"
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
      uri = URI.parse(URI.encode(url))
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      req = Net::HTTP::Post.new(uri.path, headers)
      req.body = "[ #{options} ]"
      response = http.request(req)
      URI.decode(response.body)
    end

    def headers
      header = {
        'User-Agent' => 'Ruby 2.2.1',
        'Content-Type' => 'application/json'
      }
      return header unless @access_token
      header.merge(Authorization: "Bearer #{@access_token}")
    end
  end
end
