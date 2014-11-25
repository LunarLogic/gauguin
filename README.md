# Gauguin

Retrieves palette of main colors, merging similar colors using [YUV space](http://en.wikipedia.org/wiki/YUV).

## Why not just use `RMagick`?

How many colors do you recognize on the image below?

![Black and white image](spec/support/pictures/black_and_white.png)

Many people would say `2`, but actually there are `256`.

It's because of the fact that to make image more smooth, borders of the figure are not pure black but consist of many gray scale colors.

It's common that images includes very similar colors, so when you want to get useful color palette, you would need to process color histogram you get from `RMagick` yourself.

This gem was created to do this for you.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'gauguin'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install gauguin

## Usage

```ruby
Gauguin::Painting.new("path/to/image.png")
```

Result for image above would be:

```ruby
{
  "rgb(4, 4, 4)" => [
    #<struct Gauguin::Color red=4, green=4, blue=4, percentage=0.0123291015625>,
    #<struct Gauguin::Color red=0, green=0, blue=0, percentage=0.0135498046875>,
    #<struct Gauguin::Color red=2, green=2, blue=2, percentage=0.013641357421875>,
    #<struct Gauguin::Color red=3, green=3, blue=3, percentage=0.1777496337890625>
  ],
  "rgb(254, 254, 254)" => [
    #<struct Gauguin::Color red=254, green=254, blue=254, percentage=0.013641357421875>,
    #<struct Gauguin::Color red=255, green=255, blue=255, percentage=0.6972198486328125>
  ]
}
```

## Custom configuration

There are `4` parameters that you can configure:

- `max_colors_count` (default value is `10`) - maximum number of colors that palette will include
- `cut_off_limit` (default value is `1000`) - limit for the first cut off - if image has too many colors it is not efficient to calculate grouping for all of them, so only `cut_off_limit` of colors of the largest percentage are used
- `min_diff` (default value is `0.003`) - parameter used while calculating which colors should be ignored. Colors are sorted by percentage, then difference between percentages is calculated and only colors with difference greater than `min_diff` are taken to consideration
- `similarity_threshold` (default value is `50`) - maximum distance in [YUV space](http://en.wikipedia.org/wiki/YUV) to consider two colors as the same while grouping

To configure any of above options you can use configuration block.
For example changing `max_colors_count` would look like this:

```ruby
Gauguin.configuration do |config|
  config.max_colors_count = 7
end
```

## Contributing

1. Fork it ( https://github.com/LunarLogic/gauguin/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
