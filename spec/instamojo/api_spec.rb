# spec/instamojo/configuration_spec.rb
require 'spec_helper'
# Instamojo plugin for Ruby
module Instamojo
  describe API do
    Instamojo.configure do |config|
      config.client_id = 'XXXX'
      config.client_secret = 'XXXXXXX'
    end
    let(:api) { API.new }

    describe '#auth_token' do
      it 'return auth token for write access' do
        response = api.auth_token
        expect(response['token_type']).to eq('Bearer')
        expect(response['access_token']).not_to nil
        expect(response['scope']).to eq('write read')
      end
    end
  end
end
