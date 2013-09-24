# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'whipped-cream/version'

Gem::Specification.new do |spec|
  spec.name          = "whipped-cream"
  spec.version       = WhippedCream::VERSION
  spec.authors       = ["Justin Campbell"]
  spec.email         = ["justin@justincampbell.me"]
  spec.description   = %q{TODO: Write a gem description}
  spec.summary       = %q{TODO: Write a gem summary}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.required_ruby_version = '>= 2.0.0'

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "cane"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
