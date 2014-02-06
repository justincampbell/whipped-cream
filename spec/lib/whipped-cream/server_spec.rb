require 'spec_helper'

describe WhippedCream::Server do
  subject(:server) { described_class.new(plugin, options) }

  let(:plugin) {
    WhippedCream::Plugin.build do
      button "Open/Close", pin: 4
    end
  }

  let(:options) { Hash.new }

  before do
    Rack::Server.stub :start
  end

  it "creates a runner with the plugin" do
    server.runner.stub :sleep

    server.runner.open_close
  end

  it "reuses the same runner" do
    expect(server.runner).to eq(server.runner)
  end

  context "with a button" do
    let(:plugin) {
      WhippedCream::Plugin.build do
        button "Open/Close", pin: 4
      end
    }

    before { server.start }

    it "creates a button route" do
      expect(server.web.routes['GET'].find { |route|
          route.first.match('/open_close')
      }).to be_true
    end
  end

  context "with a switch" do
    let(:plugin) {
      WhippedCream::Plugin.build do
        switch "Light", pin: 18
      end
    }

    before { server.start }

    it "creates a switch route" do
      expect(server.web.routes['POST'].find { |route|
        route.first.match('/light')
      }).to be_true
    end
  end

  describe "#start" do
    it "starts a Rack server" do
      expect(Rack::Server).to receive(:start).with(
        app: WhippedCream::Web, Port: 8080, daemonize: false
      )

      server.start
    end

    context "with daemonize: true" do
      let(:options) {
        { daemonize: true }
      }

      it "starts the Rack server daemonized" do
        expect(Rack::Server).to receive(:start).with(
          app: WhippedCream::Web, Port: 8080, daemonize: true
        )

        server.start
      end
    end

    context "with port: 1234" do
      let(:options) {
        { port: 1234 }
      }

      it "starts the Rack server on a specific port" do
        expect(Rack::Server).to receive(:start).with(
          app: WhippedCream::Web, Port: 1234, daemonize: false
        )

        server.start
      end
    end
  end
end
