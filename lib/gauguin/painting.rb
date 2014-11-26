module Gauguin
  class Painting
    def initialize(path, image_repository = nil, retriever = nil, clusterer = nil)
      @image_repository = image_repository || Gauguin::ImageRepository.new
      @image = @image_repository.get(path)
      @retiever = retriever || Gauguin::ColorsRetriever.new(@image)
      @clusterer = clusterer || Gauguin::ColorsClusterer.new
    end

    def palette
      colors = @retiever.colors
      cut_off_index = cut_off_index(colors)
      colors = colors[cut_off_index..-1]
      limited_clusters(colors)
    end

    def cut_off_index(colors)
      if colors.count > Gauguin.configuration.cut_off_limit
        return Gauguin.configuration.cut_off_limit
      end

      guard = Gauguin::Color.new(nil, nil, nil, 0)
      colors_with_guard = [guard] + colors
      zipped = colors.zip(colors_with_guard)
      diffs = zipped.map do |color, following_color|
        color.percentage - following_color.percentage
      end.compact

      diffs.index { |diff| diff > Gauguin.configuration.min_diff } || 0
    end

    def limited_clusters(colors)
      clusters = @clusterer.cluster(colors)
      clusters = clusters.sort_by { |color, _| color.percentage }.reverse
      Hash[clusters[0..Gauguin.configuration.max_colors_count-1]]
    end
  end
end

