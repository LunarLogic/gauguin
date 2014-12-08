require 'spec_helper'

module Gauguin
  describe Painting do
    let(:path) do
      File.join("spec", "support", "pictures", file_name)
    end

    let(:gray) { Color.new(204, 204, 204) }
    let(:black) { Color.new(0, 0, 0) }
    let(:white) { Color.new(255, 255, 255) }

    let(:painting) { Painting.new(path) }

    describe "#palette" do
      shared_examples_for "retrieves unique colors" do
        it { expect(subject.count).to eq 5 }
        it do
          expect(subject.keys).to include(white)
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

      context "image has two colors but with different gradients
        so actually 1942 unique colors" do
        let(:file_name) { "gray_and_black.png" }
        let(:values) { subject.values.flatten }

        it { expect(subject.count).to eq 2 }
        it { expect(values.include?(black)).to be true }
        it { expect(values.include?(gray)).to be true }
      end

      context "transparent background" do
        let(:file_name) { "transparent_background.png" }

        it { expect(subject.count).to eq 1 }
        it do
          expect(subject.keys).to eq [Color.new(2, 0, 0)]
        end
      end

      context "image with 10 colors" do
        let(:file_name) { "10_colors.png" }

        it { expect(subject.count).to eq 10 }
      end

      context "image with over than max_colors_count colors" do
        let(:file_name) { "12_colors.png" }

        it { expect(subject.count).to eq 10 }

        context "image with over than colors_limit colors" do
          configure(:colors_limit, 9)
          configure(:max_colors_count, 12)

          it "returns colors_limit colors" do
            expect(subject.count).to eq 9
          end
        end
      end
    end
  end
end

