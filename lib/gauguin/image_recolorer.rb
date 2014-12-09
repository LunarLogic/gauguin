module Gauguin
  class ImageRecolorer
    def initialize(image)
      @image = image.dup
    end

    def recolor(new_colors)
      rows = @image.rows
      columns = @image.columns

      (0...rows).each do |row|
        (0...columns).each do |column|
          image_pixel = @image.pixel_color(row, column)
          next if image_pixel.transparent?

          color = Color.new(*image_pixel.to_rgb)
          new_color = new_colors[color]

          next unless new_color

          @image.pixel_color(row, column, new_color.to_s)
        end
      end
      @image
    end
  end
end
