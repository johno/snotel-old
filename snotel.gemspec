# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'snotel/version'

Gem::Specification.new do |spec|
  spec.name          = "snotel"
  spec.version       = Snotel::VERSION
  spec.authors       = ["John Otander"]
  spec.email         = ["johnotander@gmail.com"]
  spec.summary       = %q{Ruby client for accessing SNOTEL station data.}
  spec.description   = %q{Ruby client for accessing SNOTEL station data for snowfall data. Supports hourly and daily granularity.}
  spec.homepage      = "https://github.com/firstchair-io/snotel"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
