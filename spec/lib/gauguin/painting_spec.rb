require 'spec_helper'

module Gauguin
  describe Painting do
    let(:black) { Color.new(0, 0, 0, 0.2) }
    let(:red) { Color.new(255, 0, 0, 0.1) }
    let(:white) { Color.new(255, 255, 255, 0.3) }

    let(:image_repository) do
      double(get: double('image'))
    end

    let(:clusterer) do
      double(
        cluster: {
          black => [black],
          red => [red],
          white => [white]
        }
      )
    end
    let(:colors) { [black, red, white] }

    let(:painting) do
      Painting.new("path", image_repository, clusterer)
    end

    describe "#limited_clusters" do
      subject { painting.limited_clusters(colors) }

      before do
        Gauguin.configuration.max_colors_count = 2
      end

      it "returns max_colors_count most common colors" do
        expect(subject).to eq({
          white => [white],
          black => [black]
        })
      end
    end
  end
end

