require 'spec_helper'

module Gauguin
  describe Color do
    let(:black) { Color.new(0, 0, 0) }
    let(:red) { Color.new(255, 0, 0) }

    context '#distance' do
      it 'returns circa 178.36 between black & red' do
        expect(black.distance(red)).to be_within(0.01).of(178.36)
      end
    end
  end
end
