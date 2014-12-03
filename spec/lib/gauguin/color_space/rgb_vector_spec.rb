require 'spec_helper'

module Gauguin::ColorSpace
  describe RgbVector do
    describe "#to_xyz" do
      let(:red) { RgbVector[255, 0, 0] }

      it "converts to lab space" do
        expect(red.to_xyz).to eq(
          XyzVector[41.24, 21.26, 1.9300000000000002])
      end
    end
  end
end

