require 'spec_helper'

module Gauguin::ColorSpace
  describe XyzVector do
    describe "#to_lab" do
      let(:red) { XyzVector[41.24, 21.26, 1.9300000000000002] }

      it "converts to lab space" do
        expect(red.to_lab).to eq(
          LabVector[53.23288178584245, 80.10930952982204, 67.22006831026425])
      end
    end
  end
end

