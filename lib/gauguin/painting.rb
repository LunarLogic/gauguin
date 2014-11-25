require 'rmagick'

module Gauguin
  class Painting
    MAX_TRANSPARENCY = 65535
    MAX_CHANNEL_VALUE = 257

    def initialize(path)
      list = Magick::ImageList.new(path)
      @image = list.first
    end

    def palette
      percentage = colors_percentage
      cut_off_index = cut_off_index(percentage)
      percentage = percentage[cut_off_index..-1]

      limited_groups(percentage)
    end

    private

    def colors_percentage
      percentage_hash = {}

      histogram = @image.color_histogram
      image_size = @image.columns * @image.rows

      histogram.to_a.each do |pixel, count|
        next unless count
        next if pixel.opacity >= MAX_TRANSPARENCY

        red, green, blue = pixel_to_rgb(pixel)
        percentage = count.to_f / image_size
        color = Gauguin::Color.new(red, green, blue, percentage)
        rgb = color.to_s

        if percentage_hash[rgb]
          percentage_hash[rgb].percentage += color.percentage
        else
          percentage_hash[rgb] = color
        end
      end
      percentage_hash.to_a.sort_by { |_, color| color.percentage }
    end

    def cut_off_index(percentage_array)
      if percentage_array.count > Gauguin.configuration.cut_off_limit
        return Gauguin.configuration.cut_off_limit
      end

      guard = Gauguin::Color.new(nil, nil, nil, 0)
      percentage_array_with_guard = [["guard", guard]] + percentage_array
      zipped = percentage_array.zip(percentage_array_with_guard)
      diffs = zipped.map do |color, following_color|
        color[1].percentage - following_color[1].percentage
      end.compact

      diffs.index { |diff| diff > Gauguin.configuration.min_diff } || 0
    end

    def limited_groups(percentage_array)
      groups = {}
      while !percentage_array.empty?
        _, color = percentage_array.shift
        groups[color.to_s] = [color]

        percentage_array.delete_if do |_, other_color|
          if other_color.similar?(color)
            groups[color.to_s] << other_color
            true
          else
            false
          end
        end
      end
      Hash[groups.to_a[0..Gauguin.configuration.max_colors_count-1]]
    end

    def pixel_to_rgb(pixel)
      [:red, :green, :blue].map do |color|
        pixel.send(color) / MAX_CHANNEL_VALUE
      end
    end
  end
end

