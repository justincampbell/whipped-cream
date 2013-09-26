require 'spec_helper'

describe WhippedCream::Sensor do
  subject(:sensor) {
    described_class.new(name, pin: pin, low: low, high: high, on_high: on_high)
  }

  let(:name) { "Door" }
  let(:pin) { 2 }
  let(:low) { "Closed" }
  let(:high) { "Open" }
  let(:on_low) { nil }
  let(:on_high) { :door_opened }

  its(:name) { should eq(name) }
  its(:pin) { should eq(pin) }
  its(:low) { should eq(low) }
  its(:high) { should eq(high) }
  its(:on_low) { should eq(on_low) }
  its(:on_high) { should eq(on_high) }

  its(:id) { should eq(:door) }
end
