require 'spec_helper'

module Gauguin
  describe NoiseReducer do
    let(:reducer) { NoiseReducer.new }

    describe "#reduce" do
      subject { reducer.reduce(colors).keys }

      let(:white) { Color.new(255, 255, 255, 0.01) }
      let(:red) { Color.new(255, 0, 0, 0.02) }
      let(:black) { Color.new(0, 0, 0, 0.97) }

      let(:colors) do
        {
          black => [black],
          red => [red],
          white => [white]
        }
      end

      configure(:min_percentage_sum, 0.96)

      it "returns only relevant colors" do
        expect(subject).to eq([black])
      end

      context "no sum greater than min_percentage_sum" do
        let(:white) { Color.new(255, 255, 255, 0.02) }
        let(:red) { Color.new(255, 0, 0, 0.01) }
        let(:black) { Color.new(0, 0, 0, 0.90) }

        it "returns all colors" do
          expect(subject).to eq([black, red, white])
        end
      end

      context "transparent color" do
        configure(:min_percentage_sum, 0.98)

        before do
          white.transparent = true
        end

        it "returns all colors except white" do
          expect(subject).to eq([black, red])
        end
      end
    end
  end
end
