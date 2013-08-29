# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'country/select/code/version'

Gem::Specification.new do |spec|
  spec.name          = "country-select-code"
  spec.version       = "1.0.0"
  spec.authors       = ["Andre Goncalves"]
  spec.email         = ["andre@questionform.com"]
  spec.description   = 'Provides a form helper to insert a country select box using the ISO 3166 country list, optionally stores just the country code. Compatible with rails 4'
  spec.summary       = 'Rails country code select helper'
  spec.homepage      = 'http://github.com/andregoncalves/country-select-code'
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
