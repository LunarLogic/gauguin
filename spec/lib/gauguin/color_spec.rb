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
      it "compares rgb vectors" do
        expect(black == Color.new(0, 0, 0)).to be true
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
  end
end
