require 'spec_helper'

module Gauguin
  describe Painting do
    def picture_path(file_name)
      File.join("spec", "support", "pictures", file_name)
    end

    let(:painting) { Painting.new(picture_path(file_name)) }

    describe "#palette" do
      shared_examples_for "retrieves unique colors" do
        it { expect(subject.count).to eq 5 }
        it { expect(subject.keys).to include("rgb(255, 255, 255)") }
      end

      subject { painting.palette }

      context "unique colors in the picture" do
        let(:file_name) { "unique_colors.png" }

        it_behaves_like "retrieves unique colors"
      end

      context "not unique colors in the picture" do
        let(:file_name) { "not_unique_colors.png" }

        it_behaves_like "retrieves unique colors"
      end

      context "image has two colors but with different gradients, so actually 256 unique colors" do
        let(:file_name) { "black_and_white.png" }

        it { expect(subject.count).to eq 2 }
        it { expect(subject.values.flatten.include?(Gauguin::Color.new(0, 0, 0))).to be true }
        it { expect(subject.values.flatten.include?(Gauguin::Color.new(255, 255, 255))).to be true }
      end

      context "transparent black" do
        let(:file_name) { "transparent_black.png" }

        it { expect(subject.count).to eq 1 }
        it { expect(subject.keys).to eq ["rgb(0, 0, 0)"] }
      end

      context "image with 10 colors" do
        let(:file_name) { "10_colors.png" }

        it { expect(subject.count).to eq 10 }
      end

      context "image with 12 colors" do
        let(:file_name) { "12_colors.png" }

        it { expect(subject.count).to eq 10 }
      end
    end
  end
end

