# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'nagelier/version'

Gem::Specification.new do |spec|
  spec.name          = "nagelier"
  spec.version       = Nagelier::VERSION
  spec.authors       = ["Gabe Martin-Dempesy", "Bonnie Barrilleaux"]
  spec.email         = ["gabe@kokiri.org", "bonnie@kokiri.org"]
  spec.description   = %q{chandelier that nags you to get off your fat ass when you haven't gotten your fitbit steps in}
  spec.summary       = %q{written for SF Science Hack Day 2013}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "fitgem"
  spec.add_dependency "serialport"
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
