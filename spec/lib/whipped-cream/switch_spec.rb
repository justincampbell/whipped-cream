require 'spec_helper'

describe WhippedCream::Switch do
  context 'valid switch' do
    subject(:switch) { described_class.new(name, pin: valid_pin) }

    let(:name) { "Light" }
    let(:valid_pin) { 18 }

    its(:name) { should eq(name) }
    its(:id) { should eq(:light) }
    its(:type) { should eq(:switch) }
    its(:pin) { should eq(18) }
  end

  context 'invalid switch' do
    let(:invalid_pin) { 3 }

    it 'should raise an error upon initialization' do
      expect { described_class.new(name, pin: invalid_pin) }.to raise_error
    end
  end
end
