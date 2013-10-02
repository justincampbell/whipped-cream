$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

puts RUBY_DESCRIPTION

unless ENV['skip_coverage']
  require 'simplecov'
  SimpleCov.start
end

require 'whipped-cream'

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.order = :random
end
