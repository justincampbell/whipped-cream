require 'spec_helper'

describe WhippedCream::Runner do
  subject(:runner) { described_class.new(plugin) }

  let(:plugin) {
    WhippedCream::Plugin.build do
      name "Garage"
    end
  }

  its(:name) { should eq("Garage") }

  context "with a button" do
    let(:plugin) {
      WhippedCream::Plugin.build do
        button "Open/Close", pin: 1
      end
    }

    it "sets up that pin with direction: :out" do
      pin = runner.pins[:open_close]

      expect(pin).to be_a(PiPiper::Pin)
      expect(pin.pin).to eq(1)
      expect(pin.direction).to eq(:out)
    end

    it "defines an open_close method that taps the pin" do
      pin = runner.pins[:open_close]

      expect(pin).to receive(:on)
      expect(runner).to receive(:sleep).with(0.25)
      expect(pin).to receive(:off)

      runner.open_close
    end
  end
end
