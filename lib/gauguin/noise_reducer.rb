module Gauguin
  class NoiseReducer
    def reduce(colors)
      colors.sort_by!(&:percentage)

      if colors.count > Gauguin.configuration.cut_off_limit
        return colors[Gauguin.configuration.cut_off_limit..-1]
      end

      guard = Gauguin::Color.new(nil, nil, nil, 0)
      colors_with_guard = [guard] + colors
      zipped = colors.zip(colors_with_guard)
      diffs = zipped.map do |color, following_color|
        color.percentage - following_color.percentage
      end

      index = diffs.index { |diff| diff > Gauguin.configuration.min_diff } || 0
      colors[index..-1]
    end
  end
end
