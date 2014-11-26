require 'spec_helper'

module Gauguin
  describe Image do
    let(:path) do
      File.join("spec", "support", "pictures", "black_and_white.png")
    end

    let(:image) { Image.new(path) }
    let(:magic_pixel) { double }

    describe "#pixel" do
      it "returns new Image::Pixel" do
        expect(Image::Pixel).to receive(:new)
        image.pixel(magic_pixel)
      end
    end

    describe Image::Pixel do
      let(:pixel) { Image::Pixel.new(magic_pixel) }

      describe "#transparent?" do
        let(:magic_pixel) { double(opacity: opacity) }
        let(:opacity) { 0 }

        subject { pixel.transparent? }

        it { expect(subject).to be false }

        context "opacity equals MAX_TRANSPARENCY" do
          let(:opacity) { Image::Pixel::MAX_TRANSPARENCY }

          it { expect(subject).to be true }
        end
      end

      describe "#to_rgb" do
        let(:magic_pixel) { double(red: 65535, green: 0, blue: 0) }

        subject { pixel.to_rgb }

        it { expect(subject).to eq([255, 0, 0]) }
      end
    end
  end
end
