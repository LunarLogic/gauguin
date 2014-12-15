require 'spec_helper'

module Gauguin
  describe ColorsClusterer do
    let(:black) { Color.new(0, 0, 0, 0.597) }
    let(:white) { Color.new(255, 255, 255, 0.4) }

    let(:clusterer) { ColorsClusterer.new }

    describe "cluster" do
      subject { clusterer.call(colors) }

      context "colors is empty" do
        let(:colors) { [] }

        it { expect(subject).to eq({}) }
      end

      context "colors includes similar colors" do
        let(:pseudo_black) { Color.new(4, 0, 0, 0.001) }
        let(:other_pseudo_black) { Color.new(5, 0, 0, 0.001) }
        let(:another_pseudo_black) { Color.new(6, 0, 0, 0.001) }

        let(:colors) do
          [black, white, pseudo_black, other_pseudo_black,
           another_pseudo_black]
        end

        it "make separate groups for them" do
          expect(subject).to eq({
            white => [white],
            black => [black, pseudo_black, other_pseudo_black,
                      another_pseudo_black]
          })
        end

        it "updates percentage of leader of each group" do
          subject
          expect(white.percentage).to eq(0.4)
          expect(black.percentage).to eq(0.6)
        end

        context "there is color with bigger percentage
                  than pivot in the group" do
          before do
            black.percentage = 0.001
            other_pseudo_black.percentage = 0.597
          end

          it "chooses it as pivot" do
            expect(subject).to eq({
              white => [white],
              other_pseudo_black => [black, pseudo_black,
                                     other_pseudo_black,
                                     another_pseudo_black]
            })
          end

          context "pivots are similar" do
            before do
              other_pseudo_black.red = 30
              another_pseudo_black.red = 60
            end

            it "merge their groups" do
              expect(subject).to eq({
                white => [white],
                other_pseudo_black => [black, pseudo_black,
                                      other_pseudo_black,
                                      another_pseudo_black]
              })
            end
          end
        end
      end

      context "colors includes different colors" do
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

    describe "#clusters" do
      let(:red) { Color.new(255, 0, 0, 0.1) }
      let(:colors) { [black, red, white] }

      subject { clusterer.clusters(colors) }

      configure(:max_colors_count, 2)

      before do
        expect(clusterer).to receive(:call).and_return({
          black => [black],
          red => [red],
          white => [white]
        })
      end

      it "returns max_colors_count most common colors" do
        expect(subject).to eq({
          white => [white],
          black => [black]
        })
      end
    end

    describe "#reversed_clusters" do
      let(:gray) { Color.new(0, 0, 10, 0.4) }
      let(:clusters) do
        {
          white => [white],
          black => [black, gray]
        }
      end

      subject { clusterer.reversed_clusters(clusters) }

      it "returns reversed clusters" do
        expect(subject).to eq({
          white => white,
          black => black,
          gray => black
        })
      end
    end
  end
end
