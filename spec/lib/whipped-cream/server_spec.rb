require 'spec_helper'

# CLI -> Server.new(plugin) -> Runner.new(plugin)

describe WhippedCream::Server do
  # Take a plugin
  # Start a runner
  # Provide a web interface for a user to interact with the plugin
  # Provide an server for a client to interact with the plugin programmatically
  subject(:server) { described_class.new(plugin) }

  let(:plugin) {
    WhippedCream::Plugin.build do
      button "Open/Close", pin: 1
    end
  }

  it "creates a runner with the plugin" do
    server.runner.stub :sleep

    expect(server.runner.open_close).to be_nil
  end

  it "reuses the runner" do
    expect(server.runner).to eq(server.runner)
  end

  it "creates the runner when the server is created" do
    expect(server.instance_variable_get(:@runner)).to be_a(WhippedCream::Runner)
  end
end
