require "bundler/gem_tasks"
require 'cane/rake_task'
require 'rspec/core/rake_task'

ENV['coverage'] = 'true'

task default: :ci

desc "Run all test suites"
task ci: [:spec, :cane]

RSpec::Core::RakeTask.new

Cane::RakeTask.new do |cane|
  cane.add_threshold 'coverage/.last_run.json', :>=, 90
end

desc "Test deploying the demo plugin to a Vagrant box"
task :vagrant do
  system 'vagrant destroy -f'
  system 'vagrant up'
  system 'bin/whipped-cream deploy demo.rb 127.0.0.1:2222'
end
