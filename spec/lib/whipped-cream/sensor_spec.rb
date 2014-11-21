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

    describe '#name' do
      subject { super().name }
      it { is_expected.to eq(name) }
    end

    describe '#id' do
      subject { super().id }
      it { is_expected.to eq(:door) }
    end

    describe '#pin' do
      subject { super().pin }
      it { is_expected.to eq(17) }
    end

    describe '#high' do
      subject { super().high }
      it { is_expected.to eq("Open") }
    end

    describe '#low' do
      subject { super().low }
      it { is_expected.to eq("Closed") }
    end

    describe '#on_high' do
      subject { super().on_high }
      it { is_expected.to eq(:door_opened) }
    end

    describe '#on_low' do
      subject { super().on_low }
      it { is_expected.to be_nil }
    end
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
