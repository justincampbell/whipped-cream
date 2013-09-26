require 'spec_helper'

# CLI -> API.new(plugin) -> Runner.new(plugin)

describe WhippedCream::API do
  # Take a plugin
  # Start a runner
  # Provide a web interface for a user to interact with the plugin
  # Provide an api for a client to interact with the plugin programmatically
  subject(:api) { described_class.new(plugin) }

  let(:plugin) {
    WhippedCream::Plugin.build do
      button "Open/Close", pin: 1
    end
  }

  it "creates a runner with the plugin" do
    api.runner.stub :sleep

    expect(api.runner.open_close).to be_nil
  end

  it "reuses the runner" do
    expect(api.runner).to eq(api.runner)
  end

  it "creates the runner when the api is created" do
    expect(api.instance_variable_get(:@runner)).to be_a(WhippedCream::Runner)
  end
end
