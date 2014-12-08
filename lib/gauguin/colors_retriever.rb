module Gauguin
  class ColorsRetriever
    def initialize(image)
      @image = image
    end

    def colors
      colors = {}

      histogram = @image.color_histogram
      image_size = @image.columns * @image.rows

      histogram.each do |pixel, count|
        image_pixel = @image.pixel(pixel)

        red, green, blue = image_pixel.to_rgb
        percentage = count.to_f / image_size
        color = Gauguin::Color.new(red, green, blue, percentage,
                                   image_pixel.transparent?)

        # histogram can contain different magic pixels for
        # the same colors with different opacity
        if colors[color]
          colors[color].percentage += color.percentage
        else
          colors[color] = color
        end
      end

      colors.values
    end
  end
end
