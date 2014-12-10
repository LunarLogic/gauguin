require 'spec_helper'

module Gauguin
  describe PaletteSerializer do
    let(:palette) do
      {
        Color.new(255, 255, 255, 0.7, true) => [Color.new(255, 0, 0, 0.7, true)]
      }
    end

    it "serializes palette" do
      dumped = PaletteSerializer.dump(palette)
      loaded = PaletteSerializer.load(dumped)

      key = loaded.keys.first
      value = loaded.values.first.first

      expect(key.class).to eq(Color)
      expect(value.class).to eq(Color)
      expect(key.to_a).to eq([255, 255, 255, 0.7, true])
      expect(value.to_a).to eq([255, 0, 0, 0.7, true])
    end
  end
end
