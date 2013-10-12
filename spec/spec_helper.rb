ENV['RUBY_ENV'] ||= 'test'

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

puts RUBY_DESCRIPTION

require 'simplecov'
SimpleCov.start

require 'whipped-cream'

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.order = :random
end
