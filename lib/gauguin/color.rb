require "matrix"

module Gauguin
  class Color < Struct.new(:red, :green, :blue, :percentage)
    YUV_MATRIX = Matrix[[0.299, 0.587, 0.114],
                        [-0.14713, -0.28886, 0.436],
                        [0.615, -0.51499, -0.10001]]

    def ==(other)
      self.red == other.red && self.green == other.green &&
        self.blue == other.blue
    end

    def similar?(other_color)
      self.distance(other_color) < Gauguin.configuration.color_similarity_threshold
    end

    def distance(other_color)
      vector = self.to_yuv.to_a.flatten
      other_vector = other_color.to_yuv.to_a.flatten

      squares = vector.zip(other_vector).map do |coordinate, other_coordinate|
        (other_coordinate - coordinate) ** 2
      end

      sum = squares.reduce(:+)
      Math.sqrt(sum)
    end

    def to_yuv
      YUV_MATRIX * Matrix[[self.red], [self.green], [self.blue]]
    end

    def to_s
      "rgb(#{self.red}, #{self.green}, #{self.blue})"
    end
  end
end

