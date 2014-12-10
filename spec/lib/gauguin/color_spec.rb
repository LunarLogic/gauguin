require 'spec_helper'

module Gauguin
  describe Color do
    let(:black) { Color.new(0, 0, 0) }
    let(:red) { Color.new(255, 0, 0) }

    describe "initialize" do
      let(:red) { 1 }
      let(:green) { 2 }
      let(:blue) { 3 }
      let(:percentage) { 0.5 }

      subject { Color.new(red, green, blue, percentage) }

      it { expect(subject.red).to eq red }
      it { expect(subject.green).to eq green }
      it { expect(subject.blue).to eq blue }
      it { expect(subject.percentage).to eq percentage }
    end

    describe "#==" do
      it "returns true for colors with the same key values" do
        expect(black == Color.new(0, 0, 0)).to be true
      end

      it "returns false if any key value is different" do
        expect(black == Color.new(0, 0, 1)).to be false
      end

      it "returns false for objects with different classes" do
        expect(black == "black").to be false
      end
    end

    describe "#similar?" do
      context "similar colors" do
        it { expect(black.similar?(Color.new(0, 0, 1))).to be true }
      end

      context "different colors" do
        it { expect(black.similar?(red)).to be false }
      end
    end

    describe '#distance' do
      it 'returns circa 178.36 between black & red' do
        expect(black.distance(red)).to be_within(0.01).of(117.34)
      end
    end

    describe "#to_lab" do
      let(:red) { 1 }
      let(:green) { 2 }
      let(:blue) { 3 }

      subject { Color.new(red, green, blue).to_lab }

      it "returns lab vector" do
        rgb_vector = double
        xyz_vector = double
        expect(ColorSpace::RgbVector).to receive(:[]).with(red, green, blue).and_return(rgb_vector)
        expect(rgb_vector).to receive(:to_xyz).and_return(xyz_vector)
        expect(xyz_vector).to receive(:to_lab)

        subject
      end
    end

    describe "#to_s" do
      subject { black.to_s }

      it { expect(subject).to eq("rgb(0, 0, 0)") }
    end

    let(:color) { Color.new(1, 2, 3, 0.4, true) }

    describe "#to_rgb" do
      subject { color.to_rgb }

      it { expect(subject).to eq([1, 2, 3]) }
    end

    describe "#to_key" do
      subject { color.to_key }

      it { expect(subject).to eq([1, 2, 3, true]) }
    end

    describe "#to_a" do
      subject { color.to_a }

      it { expect(subject).to eq([1, 2, 3, 0.4, true]) }
    end

    describe ".from_a" do
      subject { Color.from_a([1, 2, 3, 0.4, true]) }

      it { expect(subject.red).to eq(1) }
      it { expect(subject.green).to eq(2) }
      it { expect(subject.blue).to eq(3) }
      it { expect(subject.percentage).to eq(0.4) }
      it { expect(subject.transparent).to be true }
    end

    describe "#transparent?" do
      subject { color.transparent? }

      it { expect(subject).to be true }
    end

    describe "#hash" do
      it "can be used as keys in the hash"  do
        hash = { Color.new(255, 255, 255) => 777 }
        expect(hash[Color.new(255, 255, 255)]).to eq(777)
      end
    end

    describe "#inspect" do
      subject { color.inspect }

      it { expect(subject).to eq("rgb(1, 2, 3)[0.4][transparent]")}
    end
  end
end
