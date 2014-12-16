require 'spec_helper'

module Gauguin
  describe Image do
    let(:path) do
      File.join("spec", "support", "pictures", "gray_and_black.png")
    end

    let(:image) { Image.new(path) }
    let(:magic_pixel) { double }

    describe "initialize" do
      context "path given" do
        subject { Image.new(path) }

        it "returns Image with magick image present" do
          expect(subject.image).not_to be nil
        end
      end

      context "empty constructor" do
        subject { Image.new }

        it "returns Image without magick image" do
          expect(subject.image).to be nil
        end
      end
    end

    describe ".blank" do
      let(:rows) { 10 }
      let(:columns) { 20 }


      it "returns blank image with transparent background" do
        blank_image = Image.blank(rows, columns)

        pixels = columns.times.map do |column|
          rows.times.map do |row|
            blank_image.pixel_color(column, row)
          end
        end.flatten

        expect(pixels.all? { |p| p.transparent? }).to be true
      end
    end

    describe "#pixel" do
      it "returns new Image::Pixel" do
        expect(Image::Pixel).to receive(:new)
        image.pixel(magic_pixel)
      end
    end

    describe "#pixel_color" do
      subject { image.pixel_color(0, 0) }

      it "returns Image::Pixel for given row and column" do
        expect(subject.to_rgb).to eq([204, 204, 204])
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
