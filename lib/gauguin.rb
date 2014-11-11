require "gauguin/version"
require "gauguin/color"
require "gauguin/painting"

module Gauguin
  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration) if block_given?
  end

  class Configuration
    DEFAULT_MAX_COLORS_COUNT = 10
    DEFAULT_CUT_OFF_LIMIT = 1000
    DEFAULT_MIN_DIFF = 0.003

    attr_accessor :max_colors_count, :cut_off_limit, :min_diff

    def initialize
      @max_colors_count = DEFAULT_MAX_COLORS_COUNT
      @cut_off_limit = DEFAULT_CUT_OFF_LIMIT
      @min_diff = DEFAULT_MIN_DIFF
    end
  end
end

Gauguin.configure

