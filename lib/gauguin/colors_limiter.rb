module Gauguin
  class ColorsLimiter
    def limit(colors)
      colors_limit = Gauguin.configuration.colors_limit

      if colors.count > colors_limit
        colors = colors.sort_by { |key, group| key.percentage }.
          reverse[0..colors_limit - 1]
      end

      colors
    end
  end
end
