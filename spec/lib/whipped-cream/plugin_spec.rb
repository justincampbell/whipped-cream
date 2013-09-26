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

  context "with a button" do
    before do
      plugin.controls << WhippedCream::Button.new("Open/Close")
    end

    its(:controls) { should_not be_empty }
    its(:buttons) { should_not be_empty }
  end
end
