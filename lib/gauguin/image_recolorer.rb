module Gauguin
  class ImageRecolorer
    def initialize(image)
      @image = image.dup
    end

    def recolor(new_colors)
      columns = @image.columns
      rows = @image.rows

      new_image = Image.blank(columns, rows)

      (0...columns).each do |column|
        (0...rows).each do |row|
          image_pixel = @image.pixel_color(column, row)
          next if image_pixel.transparent?

          color = Color.new(*image_pixel.to_rgb)
          new_color = new_colors[color]

          next unless new_color

          new_image.pixel_color(column, row, new_color.to_s)
        end
      end
      new_image
    end
  end
end
