require 'spec_helper'

module Gauguin
  describe "samples" do
    def self.picture_path(file_name)
      File.join("spec", "support", "pictures", file_name)
    end

    let(:painting) { Painting.new(picture_path(file_name)) }

    def self.paths
      (1..11).map { |i| picture_path(File.join("samples", "sample#{i}.png")) }
    end

    def self.expected_results
      [
        ["rgb(219, 12, 38)", "rgb(255, 255, 255)"],
        ["rgb(168, 36, 40)", "rgb(255, 255, 255)"],
        ["rgb(0, 0, 0)", "rgb(255, 255, 255)"],
        ["rgb(154, 79, 54)", "rgb(187, 196, 201)", "rgb(236, 112, 48)", "rgb(28, 28, 64)", "rgb(92, 54, 59)"],
        ["rgb(254, 254, 254)", "rgb(255, 195, 13)", "rgb(60, 4, 67)"],
        ["rgb(2, 0, 0)"],
        ["rgb(148, 158, 149)", "rgb(198, 64, 63)"],
        ["rgb(109, 207, 246)", "rgb(237, 28, 36)", "rgb(255, 255, 255)"],
        ["rgb(255, 255, 255)", "rgb(87, 196, 15)"],
        ["rgb(240, 110, 170)", "rgb(255, 255, 255)"],
        ["rgb(0, 165, 19)", "rgb(0, 71, 241)", "rgb(230, 27, 49)", "rgb(249, 166, 0)", "rgb(255, 255, 255)"]
      ]
    end

    def self.samples
      Hash[paths.zip(expected_results)]
    end

    samples.each do |sample_path, expected_result|
      it "returns expected result for #{sample_path}" do
        painting = Painting.new(sample_path)
        expect(painting.palette.keys.map(&:to_s).sort).to eq(expected_result.sort)
      end
    end
  end
end

