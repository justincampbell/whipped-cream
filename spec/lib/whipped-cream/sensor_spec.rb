require 'spec_helper'

describe WhippedCream::Sensor do
  subject(:sensor) { described_class.new(name, options, &block) }

  let(:name) { "Door" }
  let(:options) {
    {
      pin: 2,
      high: "Open",
      low: "Closed",
      on_high: :door_opened
    }
  }
  let(:block) { nil }

  its(:name) { should eq(name) }
  its(:id) { should eq(:door) }

  its(:pin) { should eq(2) }

  its(:high) { should eq("Open") }
  its(:low) { should eq("Closed") }

  its(:on_high) { should eq(:door_opened) }
  its(:on_low) { should be_nil }
end
