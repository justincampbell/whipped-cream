require "bundler/gem_tasks"
require 'cane/rake_task'
require 'rspec/core/rake_task'

task default: :ci

task ci: [:spec, :cane]

RSpec::Core::RakeTask.new

Cane::RakeTask.new do |cane|
  cane.add_threshold 'coverage/.last_run.json', :>=, 95
end
