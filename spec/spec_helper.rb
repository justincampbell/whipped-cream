$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'whipped-cream'

puts RUBY_DESCRIPTION

RSpec.configure do |config|
  config.order = :random
end
