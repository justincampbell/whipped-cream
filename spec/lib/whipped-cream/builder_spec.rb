require 'spec_helper'

describe WhippedCream::Builder do
  subject { plugin }

  let(:plugin) {
    described_class.build do
      name "Garage"
    end
  }
  let(:plugin_file_path) { "foo/bar/baz" }
  let(:plugin_string) {
    <<-PLUGIN
        name "Garage"

        button "Open/Close", pin: 4
    PLUGIN
  }

  it "returns a plugin" do
    is_expected.to be_a(WhippedCream::Plugin)
  end

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

  describe ".from_file" do
    before do
      allow(File).to receive_messages read: plugin_string
    end

    it "reads the file" do
      expect(File).to receive(:read).with(plugin_file_path)

      described_class.from_file plugin_file_path
    end

    it "parses the contents" do
      plugin = described_class.from_file(plugin_file_path)

      expect(plugin.name).to eq("Garage")
      expect(plugin.controls.first.name).to eq("Open/Close")
    end
  end

  describe ".from_string" do
    it "parses the string" do
      plugin = described_class.from_string(plugin_string)

      expect(plugin.name).to eq("Garage")
      expect(plugin.controls.first.name).to eq("Open/Close")
    end
  end

  describe "#camera" do
    subject { plugin.camera }

    it { is_expected.to be_falsey }

    context "with camera in the plugin" do
      let(:plugin) {
        described_class.build do
          camera
        end
      }

      it { is_expected.to be_truthy }
    end
  end

  describe "#button" do
    subject { plugin.buttons }

    it { is_expected.to be_empty }

    context "with a button" do
      let(:plugin) {
        described_class.build do
          button "Open/Close", pin: 4 do
            :tap
          end
        end
      }

      it "adds a button" do
        expect(plugin.buttons.size).to eq(1)

        button = plugin.buttons.first

        expect(button.name).to eq("Open/Close")
        expect(button.pin).to eq(4)
      end
    end
  end

  describe "#sensor(s)" do
    subject { plugin.sensors }

    it { is_expected.to be_empty }

    context "with a sensor" do
      let(:plugin) {
        described_class.build do
          sensor "Door",
            pin: 17,
            low: "Closed",
            high: "Open",
            on_high: :door_opened
        end
      }

      it "adds a sensor" do
        expect(plugin.sensors.size).to eq(1)

        sensor = plugin.sensors.first

        expect(sensor.name).to eq("Door")
        expect(sensor.pin).to eq(17)
        expect(sensor.low).to eq("Closed")
        expect(sensor.high).to eq("Open")
        expect(sensor.on_high).to eq(:door_opened)
        expect(sensor.block).to be_nil
      end
    end
  end

  describe "#switch" do
    subject { plugin.switches }

    it { is_expected.to be_empty }

    context "with a switch" do
      let(:plugin) {
        described_class.build do
          switch "Light", pin: 18
        end
      }

      it "adds a switch" do
        expect(plugin.switches.size).to eq(1)

        switch = plugin.switches.first

        expect(switch.name).to eq("Light")
        expect(switch.pin).to eq(18)
      end
    end
  end
end
