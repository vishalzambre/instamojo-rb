# spec/instamojo/configuration_spec.rb
require 'spec_helper'
# Instamojo plugin for Ruby
module Instamojo
  describe Configuration do
    describe '#client_id' do
      it 'client_id value is nil' do
        Configuration.new.client_id = nil
      end
    end

    describe '#client_id=' do
      it 'can set value' do
        config = Configuration.new
        config.client_id = 'HKJHJKHKHK'
        expect(config.client_id).to eq('HKJHJKHKHK')
      end
    end
  end
end
