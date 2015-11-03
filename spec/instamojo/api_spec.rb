# spec/instamojo/configuration_spec.rb
require 'spec_helper'
# Instamojo plugin for Ruby
module Instamojo
  describe API do
    Instamojo.configure do |config|
      config.client_id = 'KwA4SpZoR2ElYybItdxbIXYq42pIyfVSfFlwKKjz'
      config.client_secret = 'fBu03SWN35XJri8HNdSEgKYHwoqvayruVy4WXURlJnKCpCTGedHRhRYujrTn3yUOKuWZgcb3AYXdvuJqXApy6GuFOWxCzxF2YMR1NP1m4oxPbIrl7vhAy40Suo1LHgMQ'
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
