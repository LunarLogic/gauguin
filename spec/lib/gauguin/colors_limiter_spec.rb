require 'spec_helper'

module Gauguin
  describe ColorsLimiter do
    describe "#limit" do
      let(:limiter) { ColorsLimiter.new }
      let(:colors) { [black, red, white] }
      let(:white) { Color.new(255, 255, 255, 0.01) }
      let(:red) { Color.new(255, 0, 0, 0.02) }
      let(:black) { Color.new(0, 0, 0, 0.97) }

      subject { limiter.limit(colors) }

      it "returns all colors" do
        expect(subject).to eq([black, red, white])
      end

      context "colors count is greater than colors_limit" do
        configure(:colors_limit, 2)

        it "reduces colors to colors_limit" do
          expect(subject).to eq([black, red])
        end
      end
    end
  end
end
