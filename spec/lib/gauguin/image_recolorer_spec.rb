require 'spec_helper'

module Gauguin
  describe ImageRecolorer do
    describe "#recolor" do
      let(:image) do
        fake = FakeImage.new

        fake.pixels = pixels
        fake.rows = pixels.count
        fake.columns = pixels.first.count
        fake.colors_to_pixels = {
          white.to_s => white_pixel,
          red.to_s => red_pixel,
          black.to_s => black_pixel
        }

        fake
      end
      let(:pixels) do
        [
          [black_pixel, white_pixel, white_pixel],
          [black_pixel, black_pixel, white_pixel],
          [black_pixel, black_pixel, black_pixel]
        ]
      end
      let(:image_recolorer) { ImageRecolorer.new(image) }
      let(:white_pixel) do
        double('white', to_rgb: [255, 255, 255], transparent?: false)
      end
      let(:black_pixel) do
        double('black', to_rgb: [0, 0, 0], transparent?: false)
      end
      let(:red_pixel) do
        double('red', to_rgb: [255, 0, 0], transparent?: false)
      end
      let(:white) { Color.new(255, 255, 255) }
      let(:black) { Color.new(0, 0, 0) }
      let(:red) { Color.new(255, 0, 0) }
      let(:new_colors) do
        {
          black => white,
          white => black
        }
      end

      subject { image_recolorer.recolor(new_colors) }

      it "recolors image based on new_colors" do
        expect(subject.pixels).to eq([
          [white_pixel, black_pixel, black_pixel],
          [white_pixel, white_pixel, black_pixel],
          [white_pixel, white_pixel, white_pixel]
        ])
      end

      context "transparent pixel" do
        let(:black_pixel) do
          double('black', to_rgb: [0, 0, 0], transparent?: true)
        end

        it "stays the same" do
          expect(subject.pixels).to eq([
            [black_pixel, black_pixel, black_pixel],
            [black_pixel, black_pixel, black_pixel],
            [black_pixel, black_pixel, black_pixel]
          ])
        end
      end

      context "color not present in new_colors" do
        let(:pixels) do
          [
            [red_pixel, white_pixel, white_pixel],
            [red_pixel, red_pixel, white_pixel],
            [red_pixel, red_pixel, red_pixel]
          ]
        end

        it "stays the same" do
          expect(subject.pixels).to eq([
            [red_pixel, black_pixel, black_pixel],
            [red_pixel, red_pixel, black_pixel],
            [red_pixel, red_pixel, red_pixel]
          ])
        end
      end
    end
  end
end
