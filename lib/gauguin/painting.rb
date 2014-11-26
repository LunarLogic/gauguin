module Gauguin
  class Painting
    def initialize(path, image_repository = nil, reducer = nil, retriever = nil, clusterer = nil)
      @image_repository = image_repository || Gauguin::ImageRepository.new
      @image = @image_repository.get(path)
      @retiever = retriever || Gauguin::ColorsRetriever.new(@image)
      @reducer = reducer || Gauguin::NoiseReducer.new
      @clusterer = clusterer || Gauguin::ColorsClusterer.new
    end

    def palette
      colors = @retiever.colors
      colors = @reducer.reduce(colors)
      limited_clusters(colors)
    end

    def limited_clusters(colors)
      clusters = @clusterer.cluster(colors)
      clusters = clusters.sort_by { |color, _| color.percentage }.reverse
      Hash[clusters[0...Gauguin.configuration.max_colors_count]]
    end
  end
end

