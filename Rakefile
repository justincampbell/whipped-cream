require "bundler/gem_tasks"
require 'cane/rake_task'
require 'rspec/core/rake_task'

VAGRANT_PORT = ENV['VAGRANT_PORT'] || 2222
ENV['coverage'] = 'true'

task default: :ci

desc "Run all test suites"
task ci: [:spec, :cane]

RSpec::Core::RakeTask.new do |rspec|
  rspec.rspec_opts = '--tag ~acceptance'
end

Cane::RakeTask.new do |cane|
  cane.add_threshold 'coverage/.last_run.json', :>=, 90
end

desc "Test deploying the demo plugin to a Vagrant box"
task :vagrant do
  [
    ['vagrant up',
     'Bringing up Debian Wheezy Vagrant box'],
    ['rake build',
     'Building the gem'],
    ["bin/whipped-cream deploy demo.rb 127.0.0.1:#{VAGRANT_PORT}",
     'Performing initial deploy'],
    ["bin/whipped-cream deploy demo.rb 127.0.0.1:#{VAGRANT_PORT}",
     'Performing subsequent deploy'],
    ['REMOTE_URL="http://localhost:8080" rspec --tag acceptance',
     'Running acceptance tests against Vagrant box']
  ].each do |command, description|
    puts yellow(description)
    puts cyan(?` + command + ?`)

    unless system(command)
      raise "Command failed: '#{command}'"
    end
  end
end

def yellow(text)
  color(3, text)
end

def cyan(text)
  color(6, text)
end

def color(number, text)
  `tput setaf #{number}` + text + `tput sgr0`
end
