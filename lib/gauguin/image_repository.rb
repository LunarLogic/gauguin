module Gauguin
  class ImageRepository
    def get(path)
      Gauguin::Image.new(path)
    end
  end
end
