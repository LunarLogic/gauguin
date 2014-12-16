# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'gauguin/version'

Gem::Specification.new do |spec|
  spec.name          = "gauguin"
  spec.version       = Gauguin::VERSION
  spec.authors       = ["Ania Slimak"]
  spec.email         = ["anna.slimak@lunarlogic.io"]
  spec.summary       = %q{Tool for retrieving main colors from the image.}
  spec.description   = %q{Retrieves palette of main colors, merging similar colors using YUV space.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "rmagick"

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "simplecov"
  spec.add_development_dependency "codeclimate-test-reporter"
  spec.add_development_dependency "guard-rspec"

  spec.add_runtime_dependency "pry"
end
