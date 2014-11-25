module Gauguin
  class ColorsClusterer
    def initialize(colors)
      @colors = colors
    end

    def cluster
      clusters = {}
      colors = @colors.dup
      while !colors.empty?
        color = colors.shift
        clusters[color] = [color]
        similar_colors = colors.select { |c| c.similar?(color) }
        clusters[color] += similar_colors
        colors -= similar_colors
      end
      clusters
    end
  end
end
