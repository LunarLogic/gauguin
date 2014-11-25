require "matrix"

module Gauguin
  class Color < Struct.new(:red, :green, :blue, :percentage)
    YUV_MATRIX = Matrix[[0.299, 0.587, 0.114],
                        [-0.14713, -0.28886, 0.436],
                        [0.615, -0.51499, -0.10001]]

    def ==(other_color)
      self.distance(other_color) < Gauguin.configuration.color_similarity_threshold
    end

    def distance(other_color)
      vector = self.to_yuv.to_a.flatten
      other_vector = other_color.to_yuv.to_a.flatten
      squares = vector.map.with_index do |_, i|
        (other_vector[i] - vector[i]) ** 2
      end
      sum = 0
      squares.each { |o| sum += o }
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

