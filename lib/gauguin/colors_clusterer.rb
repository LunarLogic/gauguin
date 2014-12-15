module Gauguin
  class ColorsClusterer
    def call(colors)
      clusters = {}
      while !colors.empty?
        pivot = colors.shift
        group = [pivot]

        while true
          similar_colors = colors.select { |c| c.similar?(pivot) }
          break if similar_colors.empty?

          group += similar_colors
          colors -= similar_colors

          pivot = group.sort_by(&:percentage).last
        end

        clusters[pivot] = group
      end

      clusters.each do |main_color, group|
        percentage = group.inject(0) do |sum, color|
          sum += color.percentage
        end
        main_color.percentage = percentage
      end

      clusters
    end

    def clusters(colors)
      clusters = self.call(colors)
      clusters = clusters.sort_by { |color, _| color.percentage }.reverse
      Hash[clusters[0...Gauguin.configuration.max_colors_count]]
    end

    def reversed_clusters(clusters)
      reversed_clusters = {}

      clusters.each do |pivot, group|
        group.each do |color|
          reversed_clusters[color] = pivot
        end
      end

      reversed_clusters
    end
  end
end
