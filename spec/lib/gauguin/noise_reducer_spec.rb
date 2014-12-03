require 'spec_helper'

module Gauguin
  describe NoiseReducer do
    let(:reducer) { NoiseReducer.new }

    describe "#reduce" do
      subject { reducer.reduce(colors).keys }

      let(:white) { Color.new(255, 255, 255, 0.01) }
      let(:red) { Color.new(255, 0, 0, 0.02) }
      let(:black) { Color.new(0, 0, 0, 0.1) }

      let(:colors) do
        {
          black => [black],
          red => [red],
          white => [white]
        }
      end

      configure(:min_diff, 0.03)

      it "returns only relevant colors" do
        expect(subject).to eq([black])
      end

      context "colors count is greater than cut_off_limit" do
        configure(:cut_off_limit, 1)

        it "reduces colors to cut_off_limit" do
          expect(subject).to eq([black, red])
        end
      end

      context "no diff greater than min_diff" do
        let(:white) { Color.new(255, 255, 255, 0.2) }
        let(:red) { Color.new(255, 0, 0, 0.4) }
        let(:black) { Color.new(0, 0, 0, 0.5) }

        it "returns all colors" do
          expect(subject).to eq([black, red, white])
        end
      end
    end
  end
end
