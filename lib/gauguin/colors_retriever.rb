module Gauguin
  class ColorsRetriever
    MAX_TRANSPARENCY = 65535

    def initialize(image)
      @image = image
    end

    def colors
      colors = []

      histogram = @image.color_histogram
      image_size = @image.columns * @image.rows

      histogram.each do |pixel, count|
        next if pixel.opacity >= MAX_TRANSPARENCY

        red, green, blue = @image.pixel_to_rgb(pixel)
        percentage = count.to_f / image_size
        color = Gauguin::Color.new(red, green, blue, percentage)
        colors << color
      end

      colors
    end
  end
end
