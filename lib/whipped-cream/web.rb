require 'sinatra'

module WhippedCream
  # A Sinatra application skeleton that is used to build up the web server
  # for this plugin.
  class Web < Sinatra::Application
    get '/' do
      find_remote_servers
      erb :index
    end

    private

    def controls
      runner.plugin.controls
    end

    def runner
      Runner.instance
    end

    def title
      runner.name
    end

    def remote_servers
      @remote_servers ||= []
    end

    def find_remote_servers
      @remote_servers = discoverer.discover
                                  .reject { |server| server[:name] == title }
    end

    def discoverer
      @discoverer ||= Discoverer.new
    end

    def server_link(server)
      address = server[:address]
      port    = server[:port]
      name    = server[:name]

      "<a href=\"http://#{address}:#{port}\">#{name}</a>"
    end
  end
end
