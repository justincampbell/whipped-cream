require 'spec_helper'

describe WhippedCream::Plugin do
  subject { plugin }

  let(:plugin) {
    described_class.build do
      name "Garage"
    end
  }

  context "with helper methods" do
    subject {
      described_class.build do
        helpers do
          def foo
            :bar
          end
        end
      end
    }

    it "defines the methods on the object" do
      expect(subject.foo).to eq(:bar)
    end
  end

  describe "#camera" do
    subject { plugin.camera }

    it { should be_false }

    context "with camera in the plugin" do
      let(:plugin) {
        described_class.build do
          camera
        end
      }

      it { should be_true }
    end
  end

  describe "#button(s)" do
    subject { plugin.buttons }

    it { should be_empty }

    context "with a button" do
      let(:plugin) {
        described_class.build do
          button "Open/Close", pin: 1 do
            :tap
          end
        end
      }

      it "adds a button" do
        expect(plugin.buttons).to have(1).item

        button = plugin.buttons.first

        expect(button[:name]).to eq("Open/Close")
        expect(button[:pin]).to eq(1)

        expect(button[:block].call).to eq(:tap)
      end
    end
  end
end
