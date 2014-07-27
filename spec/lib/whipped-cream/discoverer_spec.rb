require 'spec_helper'

describe WhippedCream::Discoverer do
  subject { discoverer }
  let(:discoverer) { described_class.new }

  describe "#list" do
    let(:host_array) { [host_double] }
    let(:host_double) {
      { name: "Test",
        address: "192.168.0.100",
        port: "8080" }
    }
    let(:output_string) {
      "#{host_double[:address]}:#{host_double[:port]}\t#{host_double[:name]}"
    }

    it "should print out the discovered host information" do
      discoverer.should_receive(:discover)
                .and_return(host_array)

      expect(discoverer).to receive(:puts).with(output_string)

      discoverer.list
    end
  end

  describe "#discover" do
    let(:service_type) { "_whipped-cream._tcp." }
    let(:services_array) { [double("reply")] }
    let(:host_double) { double("host") }

    it "displays the host information for any running servers" do
      discoverer.should_receive(:browse_services)
                .with(service_type)
                .and_return(services_array)

      discoverer.should_receive(:resolve_service)
                .with(services_array.first)
                .and_return(host_double)

      discoverer.discover
    end
  end

  #:nocov:
  describe "#browse_services" do
    let(:service_type) { '_whipped-cream._tcp.' }

    it "should call DNSSD::Services#browse" do
      DNSSD::Service.any_instance
                    .should_receive(:browse)
                    .with(service_type)

      discoverer.send(:browse_services, service_type)
    end
  end

  describe "#resolve_service" do
    let(:service_double) { double("service") }

    it "should call DNSSD::Services#resolve" do
      DNSSD::Service.any_instance
                    .should_receive(:resolve)
                    .with(service_double)

      discoverer.send(:resolve_service, service_double)
    end
  end

  describe "#get_ipv4_address" do
    let(:reply_double) { double("dnssd_reply") }

    it "should call DNSSD::Services#getaddrinfo" do
      reply_double.stub(:target).and_return("test_host")

      DNSSD::Service.any_instance
                    .should_receive(:getaddrinfo)
                    .with(reply_double.target, 1)

      discoverer.send(:get_ipv4_address, reply_double)
    end
  end
  #:nocov:
end
