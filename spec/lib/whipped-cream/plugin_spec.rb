require 'spec_helper'

describe WhippedCream::Plugin do
  subject(:plugin) { described_class.new }

  its(:camera) { should be_nil }
  its(:name) { should be_nil }

  its(:controls) { should be_empty }

  its(:buttons) { should be_empty }
  its(:fields) { should be_empty }
  its(:sensors) { should be_empty }
  its(:switches) { should be_empty }

  describe ".build" do
    it "delegates to Builder" do
      block = -> {}
      expect(WhippedCream::Builder).to receive(:build).with(&block)
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

    its(:controls) { should_not be_empty }
    its(:buttons) { should_not be_empty }
  end
end
