require 'spec_helper'
require 'faraday'
require 'timeout'

describe 'Whipped Cream', :acceptance do
  let(:http) { Faraday.new(url: url) }
  let(:request_method) { :get }
  let(:response) { http.send(request_method, path) }

  let(:remote_url) { ENV['REMOTE_URL'] }
  let(:url) { remote_url || 'http://127.0.0.1:8080' }
  let(:path) { '' }

  around do |example|
    start_server unless remote_url
    wait_for_server(1)
    example.yield
    kill_server unless remote_url
  end

  describe 'GET /' do
    let(:path) { '/' }

    it "succeeds" do
      expect(response).to be_success
    end
  end
end

def start_server
  `bin/whipped-cream start demo.rb --daemonize`
end

def kill_server
  `pkill -9 -f whipped-cream`
end

def wait_for_server(duration)
  Timeout.timeout(duration) do
    begin
      http.get
    rescue Faraday::Error::ConnectionFailed
      sleep 0.01
      retry
    end
  end
end
