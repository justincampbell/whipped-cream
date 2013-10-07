require 'spec_helper'

describe WhippedCream::Switch do
  subject(:switch) { described_class.new(name, pin: pin) }

  let(:name) { "Light" }
  let(:pin) { 3 }

  its(:name) { should eq(name) }
  its(:id) { should eq(:light) }
  its(:type) { should eq(:switch) }
  its(:pin) { should eq(3) }
end
