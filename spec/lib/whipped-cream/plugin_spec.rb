require 'spec_helper'

describe WhippedCream::Plugin do
  subject(:plugin) { described_class.new }

  describe '#camera' do
    subject { super().camera }
    it { is_expected.to be_nil }
  end

  describe '#name' do
    subject { super().name }
    it { is_expected.to be_nil }
  end

  describe '#controls' do
    subject { super().controls }
    it { is_expected.to be_empty }
  end

  describe '#buttons' do
    subject { super().buttons }
    it { is_expected.to be_empty }
  end

  describe '#fields' do
    subject { super().fields }
    it { is_expected.to be_empty }
  end

  describe '#sensors' do
    subject { super().sensors }
    it { is_expected.to be_empty }
  end

  describe '#switches' do
    subject { super().switches }
    it { is_expected.to be_empty }
  end

  describe ".build" do
    it "delegates to Builder" do
      double = double('block')
      block = -> { double.run }

      expect(WhippedCream::Builder).to receive(:build).with(no_args).and_yield
      expect(double).to receive(:run)

      described_class.build(&block)
    end
  end

  describe ".from_file" do
    it "delegates to Builder" do
      path = "foo/bar"
      expect(WhippedCream::Builder).to receive(:from_file).with(path)
      described_class.from_file(path)
    end
  end

  describe ".from_string" do
    it "delegates to Builder" do
      string = "name 'Garage'"
      expect(WhippedCream::Builder).to receive(:from_string).with(string)
      described_class.from_string(string)
    end
  end

  context "with a button" do
    before do
      plugin.controls << WhippedCream::Button.new("Open/Close", pin: 4)
    end

    describe '#controls' do
      subject { super().controls }
      it { is_expected.not_to be_empty }
    end

    describe '#buttons' do
      subject { super().buttons }
      it { is_expected.not_to be_empty }
    end
  end
end
