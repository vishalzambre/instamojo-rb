require 'uri'
require 'net/http'
require 'net/https'

module Instamojo
  # Manage sync call between instamojo
  class API
    attr_accessor :config, :access_token, :refresh_token, :header

    TEST_URL = 'https://test.instamojo.com'.freeze
    LIVE_URL = 'https://instamojo.com'.freeze

    def initialize(config = Instamojo.configuration)
      @config = config
      @header = true
    end

    # Generate authentication token
    def auth_token
      @access_token = nil
      token(credentials('client_credentials'))
    end

    # Refresh existing token
    def refresh_token
      token(credentials('refresh_token').merge(refresh_token: @refresh_token))
    end

    # create new account to instamojo
    def signup(options = {})
      auth_token unless @access_token
      options[:referrer] ||= config.referrer
      @header = true
      signup_url = "#{url}/v2/users/"
      post(signup_url, options)
    end

    # Generate user access token
    def user_token(options = {})
      token(options.merge(credentials('password')))
    end

    # Update bank detail to instamojo
    def inrbankaccount(user_id, options = {})
      check_token
      @header = true
      bank_url = "#{url}/v2/users/#{user_id}/inrbankaccount/"
      put(bank_url, options)
    end

    # Create a payment link
    def payment_link(options = {})
      check_token
      @header = true
      payment_url = "#{url}/v2/payment_requests/"
      post(payment_url, options)
    end

    # Get detail of payment
    def payment_details(payment_request_id)
      check_token
      payment_url = "#{url}/v2/payment_requests/#{payment_request_id}/"
      @header = true
      get(payment_url)
    end

    # Get payment status
    def payment_status(payment_request_id)
      check_token
      api_url = config.mode == :production ? 'https://api.instamojo.com' : url
      payment_url = "#{api_url}/v2/payments/#{payment_request_id}/"
      @header = true
      get(payment_url)
    end

    private

    # Generate token
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

    %w(post put get).each do |method|
      define_method "#{method}" do |url, options = {}|
        uri = URI(url)
        req = "Net::HTTP::#{method.titleize}".constantize.new(uri.path)
        headers.each do |key, value|
          req[key] = value
        end
        req.set_form_data(options)
        response =
          Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
            http.request(req)
          end
        JSON.parse(URI.decode(response.body))
      end
    end

    def headers
      http_header = {
        'Content-Type' => 'application/x-www-form-urlencoded',
        'Accept' => 'application/json'
      }
      return http_header unless header || @access_token
      http_header.merge('Authorization' => "Bearer #{@access_token}")
    end

    def check_token
      fail 'Please generate access token' unless @access_token
    end
  end
end
