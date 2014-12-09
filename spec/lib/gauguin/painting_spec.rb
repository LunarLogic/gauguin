require 'spec_helper'

module Gauguin
  describe Painting do
    let(:colors) { [] }

    let(:image_repository) { double(get: double('image')) }
    let(:colors_retriever) { double }
    let(:colors_limiter) { double }
    let(:noise_reducer) { double }
    let(:colors_clusterer) { double }
    let(:image_recolorer) { double }

    let(:clusters) { {} }

    let(:painting) do
      Painting.new("path", image_repository, colors_retriever,
                   colors_limiter, noise_reducer,
                   colors_clusterer, image_recolorer)
    end

    describe "#palette" do
      it "returns hash with main colors of the image" do
        expect(colors_retriever).to receive(:colors).
          and_return(colors)
        expect(colors_limiter).to receive(:limit).with(colors).
          and_return(colors)
        expect(colors_clusterer).to receive(:clusters).with(colors).
          and_return(clusters)
        expect(noise_reducer).to receive(:reduce).with(colors).
          and_return(colors)

        painting.palette
      end
    end

    describe "#recolor" do
      let(:palette) { {} }
      let(:path) { 'path' }
      let(:image) { double(write: nil) }
      let(:new_colors) { {} }

      it "recolors and writes the image to given path" do
        expect(colors_clusterer).to receive(:reversed_clusters).
          with(palette).and_return(new_colors)
        expect(image_recolorer).to receive(:recolor).
          with(new_colors).and_return(image)
        expect(image).to receive(:write).with(path)

        painting.recolor(palette, path)
      end
    end
  end
end

