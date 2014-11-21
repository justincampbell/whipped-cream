require 'spec_helper'

describe WhippedCream::Switch do
  context 'valid switch' do
    subject(:switch) { described_class.new(name, pin: valid_pin) }

    let(:name) { "Light" }
    let(:valid_pin) { 18 }

    describe '#name' do
      subject { super().name }
      it { is_expected.to eq(name) }
    end

    describe '#id' do
      subject { super().id }
      it { is_expected.to eq(:light) }
    end

    describe '#type' do
      subject { super().type }
      it { is_expected.to eq(:switch) }
    end

    describe '#pin' do
      subject { super().pin }
      it { is_expected.to eq(18) }
    end
  end

  context 'invalid switch' do
    let(:invalid_pin) { 3 }

    it 'should raise an error upon initialization' do
      expect { described_class.new(name, pin: invalid_pin) }.to raise_error
    end
  end
end
