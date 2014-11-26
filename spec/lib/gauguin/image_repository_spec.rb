require 'spec_helper'

module Gauguin
  describe ImageRepository do
    let(:repository) { ImageRepository.new }
    let(:path) { "path" }

    describe "#get" do
      it "returns image" do
        expect(Gauguin::Image).to receive(:new).with(path)
        repository.get(path)
      end
    end
  end
end
