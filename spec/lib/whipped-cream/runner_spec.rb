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
        button "Open/Close", pin: 4
      end
    }

    it "sets up that pin with direction: :out" do
      pin = runner.pins[:open_close]

      expect(pin).to be_a(PiPiper::Pin)
      expect(pin.pin).to eq(4)
      expect(pin.direction).to eq(:out)
    end

    it "defines an open_close method that taps the pin" do
      pin = runner.pins[:open_close]

      expect(pin).to receive(:on)
      expect(runner).to receive(:sleep).with(0.25)
      #expect(pin).to receive(:off)

      runner.open_close.join
    end
  end

  context "with a sensor" do
    let(:plugin) {
      WhippedCream::Plugin.build do
        sensor "Door", pin: 17, low: "Open", high: "Closed"
      end
    }

    it "sets up that pin with direction: :in" do
      pin = runner.pins[:door]

      expect(pin).to be_a(PiPiper::Pin)
      expect(pin.pin).to eq(17)
      expect(pin.direction).to eq(:in)
    end

    it "defines a method that reads and converts the pin's value" do
      pin = runner.pins[:door]
      pin.stub read: 1

      expect(runner.door).to eq("Closed")
    end

    context "with a block and no pin" do
      let(:plugin) {
        WhippedCream::Plugin.build do
          sensor "Foo" do
            "Bar"
          end
        end
      }

      it "does not set up a pin" do
        expect(runner.pins[:door]).to be_nil
      end

      it "defines a method that calls the block" do
        expect(runner.foo).to eq("Bar")
      end
    end
  end

  context "with a switch" do
    let(:plugin) {
      WhippedCream::Plugin.build do
        switch "Light", pin: 18
      end
    }

    it "sets up that pin with direction: :out" do
      pin = runner.pins[:light]

      expect(pin).to be_a(PiPiper::Pin)
      expect(pin.pin).to eq(18)
      expect(pin.direction).to eq(:out)
    end

    it "defines a light method that switches the pin on and off" do
      pin = runner.pins[:light]

      expect(runner.read_pin(pin)).to eq(:off)
      runner.light(:on)
      expect(runner.read_pin(pin)).to eq(:on)
      runner.light(:off)
      expect(runner.read_pin(pin)).to eq(:off)
      runner.light(:on)
      expect(runner.read_pin(pin)).to eq(:on)
    end
  end
end
