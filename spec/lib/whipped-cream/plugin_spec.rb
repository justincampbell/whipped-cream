require 'spec_helper'

describe WhippedCream::Plugin do
  subject(:plugin) { described_class.new }

  its(:camera) { should be_nil }
  its(:name) { should be_nil }

  its(:buttons) { should be_a(Array) }
  its(:fields) { should be_a(Array) }
  its(:sensors) { should be_a(Array) }
  its(:switches) { should be_a(Array) }
end
