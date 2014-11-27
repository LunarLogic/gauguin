require 'spec_helper'

module Gauguin
  describe "samples" do
    def self.picture_path(file_name)
      File.join("spec", "support", "pictures", file_name)
    end

    let(:painting) { Painting.new(picture_path(file_name)) }

    def self.paths
      (1..10).map { |i| picture_path(File.join("samples", "sample#{i}.png")) }
    end

    def self.expected_results
      [
        ["rgb(211, 17, 52)", "rgb(255, 255, 255)"],
        ["rgb(168, 36, 40)", "rgb(255, 255, 255)"],
        ["rgb(1, 1, 1)", "rgb(254, 254, 254)"],
        ["rgb(187, 196, 201)", "rgb(28, 28, 64)", "rgb(236, 112, 48)"],
        ["rgb(254, 254, 254)", "rgb(60, 4, 67)", "rgb(255, 195, 13)"],
        ["rgb(0, 0, 0)"],
        ["rgb(198, 64, 63)", "rgb(141, 151, 142)"],
        ["rgb(215, 216, 215)", "rgb(109, 207, 246)", "rgb(237, 28, 36)"],
        ["rgb(255, 255, 255)", "rgb(87, 196, 15)"],
        ["rgb(241, 110, 170)", "rgb(255, 255, 255)"]
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

