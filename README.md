[![Build Status](https://travis-ci.org/LunarLogic/gauguin.svg?branch=master)](https://travis-ci.org/LunarLogic/gauguin)
[![Code Climate](https://codeclimate.com/github/LunarLogic/gauguin/badges/gpa.svg)](https://codeclimate.com/github/LunarLogic/gauguin)
[![Test Coverage](https://codeclimate.com/github/LunarLogic/gauguin/badges/coverage.svg)](https://codeclimate.com/github/LunarLogic/gauguin)

<img src="http://gauguin.lunarlogic.io/assets/gauguin-b7a7737e8ede819b98df9d05f7df020a.png" alt="Guard Icon" align="left" />
# Gauguin

Retrieves palette of main colors, merging similar colors using [Lab color space](http://en.wikipedia.org/wiki/Lab_color_space).

## Why not just use `RMagick`?

How many colors do you recognize on the image below?

![Black and white image](spec/support/pictures/gray_and_black.png)

Many people would say `2`, but actually there are `1942`.

It's because of the fact that to make image more smooth, borders of the figure are not pure black but consist of many gray scale colors.

It's common that images includes very similar colors, so when you want to get useful color palette, you would need to process color histogram you get from `RMagick` yourself.

This gem was created to do this for you.

## Sample app

Sample application available here: http://gauguin.lunarlogic.io

## Requirements

Gem depends on `RMagick` which requires `ImageMagick` to be installed.

### Ubuntu

    $ sudo apt-get install imagemagick

### OSX

    $ brew install imagemagick

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

#### Palette

```ruby
palette = Gauguin::Painting.new("path/to/image.png").palette
```

Result for image above would be:

```ruby
  {
    rgb(204, 204, 204)[0.5900935269505287] => [
      rgb(77, 77, 77)[7.383706620723603e-05],
      rgb(85, 85, 85)[0.00012306177701206005],
      # ...
      rgb(219, 220, 219)[1.2306177701206005e-05],
      rgb(220, 220, 220)[7.383706620723603e-05]
    ],
    rgb(0, 0, 0)[0.40990647304947003] => [
      rgb(0, 0, 0)[0.40990647304947003],
      rgb(1, 1, 1)[0.007912872261875462],
      # ...
      rgb(64, 64, 64)[6.153088850603002e-05],
      rgb(66, 66, 66)[6.153088850603002e-05]
    ]
  }
```

Where keys are instances of `Gauguin::Color` class and values are array of instances of `Gauguin::Color` class.

#### Recolor

There is also recolor feature - you can pass original image and the calculated palette and return new image, colored only with the main colours from the palette.

```ruby
painting.recolor(palette, 'path/where/recolored/file/will/be/placed')
```

## Custom configuration

There are `4` parameters that you can configure:

- `max_colors_count` (default value is `10`) - maximum number of colors that a palette will include
- `colors_limit` (default value is `10000`) - maximum number of colors that will be considered while calculating a palette - if image has too many colors it is not efficient to calculate grouping for all of them, so only `colors_limit` of colors of the largest percentage are used
- `min_percentage_sum` (default value is `0.981`) - parameter used while calculating which colors should be ignored. Colors are sorted by percentage in descending order, then colors which percentages sums to `min_percentage_sum` are taken into consideration
- `color_similarity_threshold` (default value is `25`) - maximum distance in [Lab color space](http://en.wikipedia.org/wiki/Lab_color_space) to consider two colors as the same while grouping

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
