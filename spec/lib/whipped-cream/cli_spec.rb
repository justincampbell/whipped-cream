require 'spec_helper'

require 'fileutils'
require 'tmpdir'

describe WhippedCream::CLI do
  subject { cli }
  let(:cli) { described_class.new }

  let(:plugin_filename) { File.join(tmpdir, "garage") }
  let(:plugin_string) {
    <<-PLUGIN
        name "Garage"

        button "Open/Close", pin: 1
    PLUGIN
  }
  let(:pi_address) { "192.168.0.123" }
  let(:tmpdir) { Dir.mktmpdir }

  before do
    File.open("#{plugin_filename}.rb", 'w') { |file| file.write plugin_string }
  end

  after do
    FileUtils.rm_rf tmpdir
  end

  describe "#demo" do
    it "launches a web server with an example plugin" do
      expect(Rack::Server).to receive(:start)

      cli.demo
    end
  end

  describe "#deploy" do
    it "deploys a plugin to a Pi" do
      deployer_double = double(WhippedCream::Deployer)

      expect(WhippedCream::Deployer).to receive(:new) { deployer_double }
      expect(deployer_double).to receive(:deploy)

      cli.deploy(plugin_filename, pi_address)
    end
  end

  describe "#start" do
    let(:server_double) { double(WhippedCream::Server) }

    it "starts a server for the plugin" do
      expect(WhippedCream::Server).to receive(:new) { server_double }
      expect(server_double).to receive(:start)

      cli.start(plugin_filename)
    end

    context "with --daemonize" do
      it "starts a server in the background" do
        expect(WhippedCream::Server).to(
          receive(:new).with { |plugin, options|
            expect(plugin).to be_a(WhippedCream::Plugin)
            expect(options).to eq({ daemonize: true })
          }.and_return(server_double)
        )
        expect(server_double).to receive(:start)

        cli.options = { daemonize: true }
        cli.start(plugin_filename)
      end
    end

    context "with --port" do
      it "starts a server on a specific port" do
        expect(WhippedCream::Server).to(
          receive(:new).with(anything, port: 1234).and_return(server_double)
        )
        expect(server_double).to receive(:start)

        cli.options = { port: 1234 }
        cli.start(plugin_filename)
      end
    end
  end

  describe "#usage" do
    it "displays a banner and help" do
      expect(cli).to receive(:puts).exactly(2).times
      expect(cli).to receive(:help)

      cli.usage
    end
  end
end
