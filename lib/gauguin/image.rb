require 'rmagick'
require 'forwardable'

module Gauguin
  class Image
    MAX_CHANNEL_VALUE = 257

    extend Forwardable
    attr_accessor :image
    delegate [:color_histogram, :columns, :rows] => :image

    def initialize(path)
      list = Magick::ImageList.new(path)
      self.image = list.first
    end

    def pixel_to_rgb(pixel)
      [:red, :green, :blue].map do |color|
        pixel.send(color) / MAX_CHANNEL_VALUE
      end
    end
  end
end

