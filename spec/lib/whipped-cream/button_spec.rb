require 'spec_helper'

describe WhippedCream::Button do
  context 'valid button' do
    subject(:button) { described_class.new(name, pin: valid_pin, block: block) }

    let(:name) { "Open/Close" }
    let(:valid_pin) { 4 }
    let(:block) { nil }

    its(:name) { should eq(name) }
    its(:id) { should eq(:open_close) }
    its(:type) { should eq(:button) }
  end

  context 'invalid button' do
    let(:invalid_pin) { 3 }

    it 'should raise an error on initialization' do
      expect { described_class.new(name, pin: invalid_pin) }.to raise_error
    end
  end
end
