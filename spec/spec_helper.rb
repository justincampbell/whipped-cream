$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'whipped-cream'

puts RUBY_DESCRIPTION

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.order = :random
end
