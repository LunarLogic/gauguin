require 'yaml'

module Gauguin
  class PaletteSerializer
    def self.load(value)
      return unless value

      value = YAML.load(value)
      value = value.to_a.map do |color_key, group|
        [Gauguin::Color.from_a(color_key), group]
      end
      Hash[value]
    end

    def self.dump(value)
      value = value.to_a.map { |color, group| [color.to_a, group] }
      value = Hash[value]
      YAML.dump(value)
    end
  end
end

