require 'matrix'

module Gauguin
  class Color
    attr_accessor :red, :green, :blue, :percentage

    def initialize(red, green, blue, percentage = 1)
      self.red = red
      self.green = green
      self.blue = blue
      self.percentage = percentage
    end

    YUV_MATRIX = Matrix[[0.299, 0.587, 0.114],
                        [-0.14713, -0.28886, 0.436],
                        [0.615, -0.51499, -0.10001]]

    def ==(other)
      self.vector == other.vector
    end

    def similar?(other_color)
      self.distance(other_color) < Gauguin.configuration.color_similarity_threshold
    end

    def distance(other_color)
      (self.to_yuv - other_color.to_yuv).r
    end

    def to_yuv
      YUV_MATRIX * vector
    end

    def vector
      Vector[self.red, self.green, self.blue]
    end

    def to_s
      "rgb(#{self.red}, #{self.green}, #{self.blue})"
    end
  end
end

