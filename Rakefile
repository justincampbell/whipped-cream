require "bundler/gem_tasks"
require 'cane/rake_task'
require 'rspec/core/rake_task'

task default: :ci

task ci: [:spec, :cane]

Cane::RakeTask.new
RSpec::Core::RakeTask.new
