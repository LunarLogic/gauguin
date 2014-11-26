require 'spec_helper'

module Gauguin
  describe ColorsRetriever do
    let(:retriever) { ColorsRetriever.new(image) }
    let(:image) do
      double(
        color_histogram: histogram,
        columns: 10,
        rows: 10
      )
    end
    let(:histogram) do
      {
        white_pixel => 20,
        black_pixel => 30,
        red_pixel => 10
      }
    end

    let(:white_pixel) { [255, 255, 255] }
    let(:red_pixel) { [255, 0, 0] }
    let(:black_pixel) { [0, 0, 0] }

    before do
      [white_pixel, black_pixel, red_pixel].each do |pixel|
        allow(pixel).to receive(:opacity).
          and_return(0)

        allow(image).to receive(:pixel_to_rgb).
          with(pixel).and_return(pixel)
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
          expect(white_pixel).to receive(:opacity).
            and_return(ColorsRetriever::MAX_TRANSPARENCY)
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
