module Instamojo
  # Store instamojo configs
  class Configuration
    attr_accessor :client_id, :client_secret, :mode

    def initialize
      @client_id = nil
      @client_secret = nil
      @mode = :test
    end
  end
end
