require 'spec_helper'

describe WhippedCream::Button do
  subject(:button) { described_class.new(name, pin: pin, block: block) }

  let(:name) { "Open/Close" }
  let(:pin) { nil }
  let(:block) { nil }

  its(:name) { should eq(name) }
  its(:id) { should eq(:open_close) }
  its(:type) { should eq(:button) }
end
