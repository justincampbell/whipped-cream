ENV['RUBY_ENV'] ||= 'test'

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

puts RUBY_DESCRIPTION

if ENV['coverage']
  require 'simplecov'

  SimpleCov.start do
    add_filter '/spec/'
  end
end

require 'whipped-cream'

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.order = :random
  config.treat_symbols_as_metadata_keys_with_true_values = true
end
