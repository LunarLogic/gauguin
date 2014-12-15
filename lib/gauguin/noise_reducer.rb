module Gauguin
  class NoiseReducer
    def call(colors_clusters)
      pivots = colors_clusters.keys.sort_by! { |key, group| key.percentage }.reverse

      percentage_sum = 0
      index = 0
      pivots.each do |color|
        percentage_sum += color.percentage
        break if percentage_sum > Gauguin.configuration.min_percentage_sum
        index += 1
      end

      reduced_clusters(colors_clusters, pivots, index)
    end

    private

    def reduced_clusters(colors_clusters, pivots, cut_off_index)
      reduced_pivots = pivots[0..cut_off_index]
      colors_clusters.select do |c|
        !c.transparent? && reduced_pivots.include?(c)
      end
    end
  end
end
