module Gauguin
  class ColorsClusterer
    def cluster(colors)
      clusters = {}
      while !colors.empty?
        color = colors.shift
        clusters[color] = [color]
        similar_colors = colors.select { |c| c.similar?(color) }
        clusters[color] += similar_colors
        colors -= similar_colors
      end

      clusters.each do |main_color, group|
        percentage = group.inject(0) do |sum, color|
          sum += color.percentage
        end
        main_color.percentage = percentage
      end

      clusters
    end

    def limited_clusters(colors)
      clusters = self.cluster(colors)
      clusters = clusters.sort_by { |color, _| color.percentage }.reverse
      Hash[clusters[0...Gauguin.configuration.max_colors_count]]
    end
  end
end
