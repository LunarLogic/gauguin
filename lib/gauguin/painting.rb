module Gauguin
  class Painting
    def initialize(path, image_repository = nil, colors_retriever = nil,
                   noise_reducer = nil, colors_clusterer = nil)
      @image_repository = image_repository || Gauguin::ImageRepository.new
      @image = @image_repository.get(path)
      @colors_retriever = colors_retriever || Gauguin::ColorsRetriever.new(@image)
      @noise_reducer = noise_reducer || Gauguin::NoiseReducer.new
      @colors_clusterer = colors_clusterer || Gauguin::ColorsClusterer.new
    end

    def palette
      colors = @colors_retriever.colors
      colors_clusters = @colors_clusterer.limited_clusters(colors)
      @noise_reducer.reduce(colors_clusters)
    end
  end
end

