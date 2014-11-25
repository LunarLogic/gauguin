require 'spec_helper'

module Gauguin
  describe ColorsClusterer do
    let(:clusterer) { ColorsClusterer.new }

    describe "cluster" do
      subject { clusterer.cluster(colors) }

      context "colors is empty" do
        let(:colors) { [] }

        it { expect(subject).to eq({}) }
      end

      context "colors includes similar colors" do
        let(:black) { double("black") }
        let(:very_very_dark_gray) { double("very_very_dark_gray") }

        let(:colors) do
          [black, very_very_dark_gray]
        end

        before do
          expect(very_very_dark_gray).to receive(:similar?).
            with(black).and_return(true)
        end

        it "cluster them to one group" do
          expect(subject).to eq({
            black => [black, very_very_dark_gray]
          })
        end
      end

      context "colors includes different colors" do
        let(:black) { double("black") }
        let(:white) { double("white") }

        let(:colors) do
          [black, white]
        end

        before do
          expect(white).to receive(:similar?).
            with(black).and_return(false)
        end

        it "make separate groups for them" do
          expect(subject).to eq({
            black => [black],
            white => [white]
          })
        end
      end
    end
  end
end
