require 'rmagick'
require 'forwardable'

module Gauguin
  class Image
    extend Forwardable
    attr_accessor :image
    delegate [:color_histogram, :columns, :rows, :write] => :image

    def initialize(path = nil)
      return unless path

      list = Magick::ImageList.new(path)
      self.image = list.first
    end

    def self.blank(columns, rows)
      blank_image = Image.new
      transparent_white = Magick::Pixel.new(255, 255, 255, Pixel::MAX_TRANSPARENCY)
      blank_image.image = Magick::Image.new(columns, rows) do
        self.background_color = transparent_white
      end
      blank_image
    end

    def pixel(magic_pixel)
      Pixel.new(magic_pixel)
    end

    def pixel_color(row, column, *args)
      magic_pixel = self.image.pixel_color(row, column, *args)
      pixel(magic_pixel)
    end

    class Pixel
      MAX_CHANNEL_VALUE = 257
      MAX_TRANSPARENCY = 65535

      def initialize(magic_pixel)
        @magic_pixel = magic_pixel
      end

      def transparent?
        @magic_pixel.opacity >= MAX_TRANSPARENCY
      end

      def to_rgb
        [:red, :green, :blue].map do |color|
          @magic_pixel.send(color) / MAX_CHANNEL_VALUE
        end
      end
    end
  end
end

