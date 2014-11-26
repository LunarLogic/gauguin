require 'spec_helper'

module Gauguin
  describe ColorsRetriever do
    let(:retriever) { ColorsRetriever.new(image) }
    let(:image) do
      FakeImage.new(magic_black_pixel, magic_white_pixel, magic_red_pixel)
    end
    let(:magic_black_pixel) { [0, 0, 0] }
    let(:magic_white_pixel) { [255, 255, 255] }
    let(:magic_red_pixel) { [255, 0, 0] }


    class FakeImage
      attr_accessor :pixels_repository

      def initialize(magic_black_pixel, magic_white_pixel, magic_red_pixel)
        @magic_black_pixel = magic_black_pixel
        @magic_white_pixel = magic_white_pixel
        @magic_red_pixel = magic_red_pixel

        @pixels_repository = {
          magic_white_pixel => Pixel.new(magic_white_pixel),
          magic_red_pixel => Pixel.new(magic_red_pixel),
          magic_black_pixel => Pixel.new(magic_black_pixel)
        }
      end

      def color_histogram
        {
          @magic_white_pixel => 20,
          @magic_black_pixel => 30,
          @magic_red_pixel => 10
        }
      end

      def columns
        10
      end

      def rows
        10
      end

      def pixel(magic_pixel)
        @pixels_repository[magic_pixel]
      end

      class Pixel
        def initialize(magic_pixel)
          @magic_pixel = magic_pixel
        end

        def to_rgb
          @magic_pixel
        end

        def transparent?
          false
        end
      end
    end

    describe "#colors" do
      subject { retriever.colors.sort_by(&:percentage) }

      it "returns array with colors with percentages ordered by percentage" do
        expect(subject).to eq([
          Color.new(255, 0, 0, 0.1),
          Color.new(255, 255, 255, 0.2),
          Color.new(0, 0, 0, 0.3)
        ])
      end

      context "transparent color" do
        before do
          white_pixel = image.pixels_repository[magic_white_pixel]
          expect(white_pixel).to receive(:transparent?).and_return(true)
        end

        it "returns colors without white" do
          expect(subject).to eq([
            Color.new(255, 0, 0, 0.1),
            Color.new(0, 0, 0, 0.3)
          ])
        end
      end
    end
  end
end
