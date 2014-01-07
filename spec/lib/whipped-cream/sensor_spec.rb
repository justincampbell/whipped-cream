require 'spec_helper'

describe WhippedCream::Sensor do
  context 'valid sensor' do
    subject(:sensor) { described_class.new(name, valid_options, &block) }

    let(:name) { "Door" }
    let(:valid_options) {
      {
        pin: 17,
        high: "Open",
        low: "Closed",
        on_high: :door_opened
      }
    }
    let(:block) { nil }

    its(:name) { should eq(name) }
    its(:id) { should eq(:door) }

    its(:pin) { should eq(17) }

    its(:high) { should eq("Open") }
    its(:low) { should eq("Closed") }

    its(:on_high) { should eq(:door_opened) }
    its(:on_low) { should be_nil }
  end

  context 'invalid sensor' do
    let(:name) { "Door" }
    let(:invalid_options) {
      {
        pin: 3,
        high: "Open",
        low: "Closed",
        on_high: :door_opened
      }
    }
    let(:block) { nil }

    it 'should raise an error on initialization' do
      expect {
        described_class.new(name, invalid_options, &block)
      }.to raise_error
    end
  end
end
