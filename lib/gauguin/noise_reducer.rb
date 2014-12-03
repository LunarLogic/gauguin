module Gauguin
  class NoiseReducer
    def reduce(colors_clusters)
      pivots = colors_clusters.keys.sort_by! { |key, group| key.percentage }

      if pivots.count > Gauguin.configuration.cut_off_limit
        return reduced_clusters(colors_clusters, pivots,
                                Gauguin.configuration.cut_off_limit)
      end

      guard = Gauguin::Color.new(nil, nil, nil, 0)
      pivots_with_guard = [guard] + pivots
      zipped = pivots.zip(pivots_with_guard)
      diffs = zipped.map do |color, following_color|
        color.percentage - following_color.percentage
      end

      index = diffs.index { |diff| diff > Gauguin.configuration.min_diff } || 0

      reduced_clusters(colors_clusters, pivots, index)
    end

    private

    def reduced_clusters(colors_clusters, pivots, cut_off_index)
      reduced_pivots = pivots[cut_off_index..-1]
      colors_clusters.select { |c| reduced_pivots.include?(c) }
    end
  end
end
