require 'spec_helper'

describe WhippedCream::Button do
  context 'valid button' do
    subject(:button) { described_class.new(name, pin: valid_pin, block: block) }

    let(:name) { "Open/Close" }
    let(:valid_pin) { 4 }
    let(:block) { nil }

    describe '#name' do
      subject { super().name }
      it { is_expected.to eq(name) }
    end

    describe '#id' do
      subject { super().id }
      it { is_expected.to eq(:open_close) }
    end

    describe '#type' do
      subject { super().type }
      it { is_expected.to eq(:button) }
    end
  end

  context 'invalid button' do
    let(:invalid_pin) { 3 }

    it 'should raise an error on initialization' do
      expect { described_class.new(name, pin: invalid_pin) }.to raise_error
    end
  end
end
