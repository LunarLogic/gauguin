require 'spec_helper'

module Gauguin
  describe Painting do
    let(:path) do
      File.join("spec", "support", "pictures", file_name)
    end

    let(:painting) { Painting.new(path) }

    describe "#palette" do
      shared_examples_for "retrieves unique colors" do
        it { expect(subject.count).to eq 5 }
        it do
          expect(subject.keys).to include(Color.new(255, 255, 255))
        end
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
        let(:values) { subject.values.flatten }

        it { expect(subject.count).to eq 2 }
        it { expect(values.include?(Gauguin::Color.new(0, 0, 0))).to be true }
        it { expect(values.include?(Gauguin::Color.new(255, 255, 255))).to be true }
      end

      context "transparent black" do
        let(:file_name) { "transparent_black.png" }

        it { expect(subject.count).to eq 1 }
        it do
          expect(subject.keys).to eq [Color.new(0, 0, 0)]
        end
      end

      context "image with 10 colors" do
        let(:file_name) { "10_colors.png" }

        it { expect(subject.count).to eq 10 }
      end

      context "image with over than max_colors_count colors" do
        let(:file_name) { "12_colors.png" }

        it { expect(subject.count).to eq 10 }

        context "image with over than cut_off_limit colors" do
          configure(:cut_off_limit, 9)

          it "returns last 3 items" do
            expect(subject.count).to eq 3
          end
        end
      end
    end
  end
end

