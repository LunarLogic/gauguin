require "gauguin/version"
require "gauguin/color"
require "gauguin/color_space"
require "gauguin/colors_retriever"
require "gauguin/colors_limiter"
require "gauguin/colors_clusterer"
require "gauguin/noise_reducer"
require "gauguin/image_recolorer"
require "gauguin/painting"
require "gauguin/image"
require "gauguin/image_repository"
require "gauguin/palette_serializer"

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
    DEFAULT_COLORS_LIMIT = 10000
    DEFAULT_MIN_PERCENTAGE_SUM = 0.981
    DEFAULT_COLOR_SIMILARITY_THRESHOLD = 25

    attr_accessor :max_colors_count, :colors_limit,
      :min_percentage_sum, :color_similarity_threshold

    def initialize
      @max_colors_count = DEFAULT_MAX_COLORS_COUNT
      @colors_limit = DEFAULT_COLORS_LIMIT
      @min_percentage_sum = DEFAULT_MIN_PERCENTAGE_SUM
      @color_similarity_threshold = DEFAULT_COLOR_SIMILARITY_THRESHOLD
    end
  end
end

Gauguin.configure

