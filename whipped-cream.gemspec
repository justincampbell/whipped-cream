# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'whipped-cream/version'

Gem::Specification.new do |spec|
  spec.name          = 'whipped-cream'
  spec.version       = WhippedCream::VERSION
  spec.authors       = ["Justin Campbell"]
  spec.email         = ["justin@justincampbell.me"]
  spec.description   = "HTTP topping for Raspberry Pi"
  spec.summary       = "HTTP topping for Raspberry Pi"
  spec.homepage      = 'https://github.com/justincampbell/whipped-cream'
  spec.license       = 'MIT'

  spec.post_install_message = File.read('WELCOME')

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 1.9.3'

  spec.add_runtime_dependency 'net-scp'
  spec.add_runtime_dependency 'net-ssh'
  spec.add_runtime_dependency 'pi_piper'
  spec.add_runtime_dependency 'sinatra'
  spec.add_runtime_dependency 'thor'
  spec.add_runtime_dependency 'dnssd'

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'cane'
  spec.add_development_dependency 'faraday'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'simplecov'
end
