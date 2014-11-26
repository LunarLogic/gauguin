require 'spec_helper'

module Gauguin
  describe NoiseReducer do
    let(:reducer) { NoiseReducer.new }

    describe "#reduce" do
      subject { reducer.reduce(colors) }
      let(:white) { Color.new(255, 255, 255, 0.3) }
      let(:red) { Color.new(255, 0, 0, 0.3) }
      let(:black) { Color.new(0, 0, 0, 0.3) }

      let(:colors) do
        [white, red, black]
      end

      before do
        Gauguin.configuration.min_diff = 0.01
      end

      it "returns only relevant colors" do
        expect(subject).to eq([
        ])
      end

      context "colors count is greater than cut_off_limit"
      context "no diff greater than min_diff"
    end
  end
end
