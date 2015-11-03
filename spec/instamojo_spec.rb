require 'spec_helper'

describe Instamojo do
  it 'has a version number' do
    expect(Instamojo::VERSION).not_to be nil
  end

  describe '#configure' do
    before :each do
      Instamojo.configure do |config|
        config.client_id = 'JHJHKHKJHJKHK'
        config.client_secret = 'LKKHJKJH&9099JHJKHJKHJKHK'
      end
    end

    it 'returns configure client_id and client_secret as empty' do
      config = Instamojo.configuration
      expect(config.client_id).to eq('JHJHKHKJHJKHK')
      expect(config.client_secret).to eq('LKKHJKJH&9099JHJKHJKHJKHK')
    end
    after :each do
      Instamojo.reset
    end
  end

  describe '.reset' do
    before do
      Instamojo.configure do |config|
        config.client_id = 'JHJHKHKJHJKHK'
        config.client_secret = 'LKKHJKJH&9099JHJKHJKHJKHK'
      end
    end

    it 'resets the configuration' do
      Instamojo.reset

      config = Instamojo.configuration

      expect(config.client_id).to be_nil
      expect(config.client_secret).to be_nil
    end
  end
end
