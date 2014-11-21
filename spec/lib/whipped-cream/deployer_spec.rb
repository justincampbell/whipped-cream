require 'spec_helper'

describe WhippedCream::Deployer do
  subject { deployer }
  let(:deployer) { described_class.new(plugin_filename, pi_address) }

  let(:plugin_filename) { 'demo.rb' }
  let(:pi_address) { '192.168.0.123' }

  let(:net_ssh_double) {
    double(Net::SSH, exec!: nil, open_channel: double(wait: nil))
  }

  before do
    allow(deployer).to receive :scp_copy
    allow(deployer).to receive :ssh_exec
  end

  describe '#plugin_filename' do
    subject { super().plugin_filename }
    it { is_expected.to eq(plugin_filename) }
  end

  describe '#pi_address' do
    subject { super().pi_address }
    it { is_expected.to eq(pi_address) }
  end

  context "with a port" do
    let(:pi_address) { "192.168.0.123:2222" }

    it "adds a port to the connection arguments" do
      expect(deployer.connection_arguments.last[:port]).to eq("2222")
    end
  end

  describe "#scp" do
    it "tries to connect with pi:raspberry" do
      expect(Net::SCP).to receive(:start).with(
        pi_address, 'pi', password: 'raspberry'
      )

      deployer.scp
    end
  end

  describe "#ssh" do
    it "tries to connect with pi:raspberry" do
      expect(Net::SSH).to receive(:start).with(
        pi_address, 'pi', password: 'raspberry'
      )

      deployer.ssh
    end
  end

  describe "#deploy" do
    subject(:deploy) { deployer.deploy }

    it "bootstraps the Pi" do
      expect(deployer).to receive(:bootstrap)
      expect(deployer).to receive(:copy_plugin)
      expect(deployer).to receive(:kill_all_plugins)
      expect(deployer).to receive(:run_plugin)

      deploy
    end

    # xit "prompts the user for a password on failure"
  end
end
