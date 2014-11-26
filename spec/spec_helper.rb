require 'simplecov'
SimpleCov.start

require 'bundler/setup'
require './lib/gauguin'
require 'pry'

Bundler.setup

RSpec.configure do |config|
end

def configure(config_option, value)
  old_value = Gauguin.configuration.send(config_option)

  before do
    Gauguin.configuration.send("#{config_option}=", value)
  end

  after do
    Gauguin.configuration.send("#{config_option}=", old_value)
  end
end
