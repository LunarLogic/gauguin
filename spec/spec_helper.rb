require 'simplecov'
SimpleCov.start

require 'bundler/setup'
require './lib/gauguin'
require 'pry'

Bundler.setup

RSpec.configure do |config|
end

def configure(config_option, value)
  old_value = Gauguin.configuration.send(config_option)

  before do
    Gauguin.configuration.send("#{config_option}=", value)
  end

  after do
    Gauguin.configuration.send("#{config_option}=", old_value)
  end
end

class FakeImage
  attr_accessor :magic_black_pixel, :magic_red_pixel,
    :magic_white_pixel, :magic_red_little_transparent_pixel,
    :pixels_repository, :color_histogram, :rows, :columns,
    :pixels, :colors_to_pixels

  def pixel(magic_pixel)
    pixels_repository[magic_pixel]
  end

  def pixel_color(row, column, new_color = nil)
    if new_color
      new_pixel = self.colors_to_pixels[new_color]
      pixels[row][column] = new_pixel
    end
    pixels[row][column]
  end

  class Pixel
    attr_accessor :magic_pixel

    def initialize(magic_pixel)
      self.magic_pixel = magic_pixel
    end

    def to_rgb
      magic_pixel.rgb
    end

    def transparent?
      false
    end
  end
end

