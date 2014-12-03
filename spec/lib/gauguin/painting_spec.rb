require 'spec_helper'

module Gauguin
  describe Painting do
    let(:colors) { [] }

    let(:image_repository) { double(get: double('image')) }
    let(:colors_retriever) { double }
    let(:noise_reducer) { double }
    let(:colors_clusterer) { double }

    let(:clusters) { {} }

    let(:painting) do
      Painting.new("path", image_repository, colors_retriever,
                   noise_reducer, colors_clusterer)
    end

    describe "#palette" do
      it "uses ColorsRetriever, NoiseReducer and ColorsClusterer" do
        expect(colors_retriever).to receive(:colors).
          and_return(colors)
        expect(colors_clusterer).to receive(:limited_clusters).with(colors).
          and_return(clusters)
        expect(noise_reducer).to receive(:reduce).with(colors).
          and_return(colors)

        painting.palette
      end
    end
  end
end

