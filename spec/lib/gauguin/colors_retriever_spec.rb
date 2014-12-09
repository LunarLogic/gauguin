require 'spec_helper'

module Gauguin
  describe ColorsRetriever do
    let(:retriever) { ColorsRetriever.new(image) }
    let(:image) do
      fake = FakeImage.new

      fake.magic_black_pixel = magic_black_pixel
      fake.magic_white_pixel = magic_white_pixel
      fake.magic_red_pixel = magic_red_pixel
      fake.magic_red_little_transparent_pixel = magic_red_little_transparent_pixel

      fake.pixels_repository = {
        magic_white_pixel => FakeImage::Pixel.new(magic_white_pixel),
        magic_red_pixel => FakeImage::Pixel.new(magic_red_pixel),
        magic_black_pixel => FakeImage::Pixel.new(magic_black_pixel),
        magic_red_little_transparent_pixel => FakeImage::Pixel.new(
          magic_red_little_transparent_pixel)
      }

      fake.color_histogram = {
        magic_white_pixel => 20,
        magic_black_pixel => 30,
        magic_red_pixel => 10
      }

      fake.rows = 10
      fake.columns = 10

      fake
    end

    def magic_pixel(rgb, opacity)
      double(rgb: rgb, opacity: opacity)
    end

    let(:magic_black_pixel) { magic_pixel([0, 0, 0], 0) }
    let(:magic_white_pixel) { magic_pixel([255, 255, 255], 0) }
    let(:magic_red_pixel) { magic_pixel([255, 0, 0], 0) }
    let(:magic_red_little_transparent_pixel) { magic_pixel([255, 0, 0], 50) }

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
