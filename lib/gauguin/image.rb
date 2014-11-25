require 'rmagick'
require 'forwardable'

module Gauguin
  class Image
    extend Forwardable
    attr_accessor :image
    delegate [:color_histogram, :columns, :rows] => :image

    def initialize(path)
      list = Magick::ImageList.new(path)
      self.image = list.first
    end
  end
end

