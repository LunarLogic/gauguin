require 'spec_helper'

module Gauguin
  describe ColorsRetriever do
    let(:retriever) { ColorsRetriever.new(image) }
    let(:image) do
      FakeImage.new([magic_black_pixel, magic_white_pixel, magic_red_pixel,
                     magic_red_little_transparent_pixel])
    end

    def magic_pixel(rgb, opacity)
      double(rgb: rgb, opacity: opacity)
    end

    let(:magic_black_pixel) { magic_pixel([0, 0, 0], 0) }
    let(:magic_white_pixel) { magic_pixel([255, 255, 255], 0) }
    let(:magic_red_pixel) { magic_pixel([255, 0, 0], 0) }
    let(:magic_red_little_transparent_pixel) { magic_pixel([255, 0, 0], 50) }


    class FakeImage
      attr_accessor :magic_black_pixel, :magic_red_pixel,
        :magic_white_pixel, :magic_red_little_transparent_pixel,
        :pixels_repository, :color_histogram, :rows, :columns

      def initialize(magic_pixels)
        self.magic_black_pixel, self.magic_white_pixel,
          self.magic_red_pixel, self.magic_red_little_transparent_pixel = magic_pixels

        self.pixels_repository = {
          magic_white_pixel => Pixel.new(magic_white_pixel),
          magic_red_pixel => Pixel.new(magic_red_pixel),
          magic_black_pixel => Pixel.new(magic_black_pixel),
          magic_red_little_transparent_pixel => Pixel.new(
            magic_red_little_transparent_pixel)
        }

        self.color_histogram = {
          magic_white_pixel => 20,
          magic_black_pixel => 30,
          magic_red_pixel => 10
        }

        self.rows = 10
        self.columns = 10
      end

      def pixel(magic_pixel)
        pixels_repository[magic_pixel]
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

    describe "#colors" do
      subject { retriever.colors.sort_by(&:percentage) }

      it "returns array with colors with percentages" do
        expect(subject).to eq([
          Color.new(255, 0, 0, 0.1),
          Color.new(255, 255, 255, 0.2),
          Color.new(0, 0, 0, 0.3)
        ])
      end

      context "histogram contains different magic pixels
        for the same color with different opacity" do
        before do
          image.color_histogram[magic_red_little_transparent_pixel] = 40
        end

        it "sums percentage" do
          expect(subject).to eq([
            Color.new(255, 255, 255, 0.2),
            Color.new(0, 0, 0, 0.3),
            Color.new(255, 0, 0, 0.5)
          ])
        end
      end
    end
  end
end
