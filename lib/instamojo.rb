require 'instamojo/version'
require 'instamojo/configuration'
require 'instamojo/api'

# Instamojo lib
module Instamojo
  class << self
    attr_accessor :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.reset
    @configuration = Configuration.new
  end

  def self.configure
    yield(configuration)
  end
end
