require "gauguin/version"
require "gauguin/color"
require "gauguin/colors_clusterer"
require "gauguin/colors_retriever"
require "gauguin/noise_reducer"
require "gauguin/painting"
require "gauguin/image"
require "gauguin/image_repository"

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
    DEFAULT_COLOR_SIMILARITY_THRESHOLD = 50

    attr_accessor :max_colors_count, :cut_off_limit,
      :min_diff, :color_similarity_threshold

    def initialize
      @max_colors_count = DEFAULT_MAX_COLORS_COUNT
      @cut_off_limit = DEFAULT_CUT_OFF_LIMIT
      @min_diff = DEFAULT_MIN_DIFF
      @color_similarity_threshold = DEFAULT_COLOR_SIMILARITY_THRESHOLD
    end
  end
end

Gauguin.configure

