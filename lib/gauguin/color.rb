module Gauguin
  class Color
    attr_accessor :red, :green, :blue, :percentage

    def initialize(red, green, blue, percentage = 1)
      self.red = red
      self.green = green
      self.blue = blue
      self.percentage = percentage
    end

    def ==(other)
      self.to_a == other.to_a
    end

    def similar?(other_color)
      self.distance(other_color) < Gauguin.configuration.color_similarity_threshold
    end

    def distance(other_color)
      (self.to_lab - other_color.to_lab).r
    end

    def to_lab
      rgb_vector = ColorSpace::RgbVector[*to_a]
      xyz_vector = rgb_vector.to_xyz
      xyz_vector.to_lab
    end

    def to_a
      [self.red, self.green, self.blue]
    end

    def to_s
      "rgb(#{self.red}, #{self.green}, #{self.blue})"
    end

    def inspect
      "#{to_s}[#{percentage}]"
    end
  end
end

