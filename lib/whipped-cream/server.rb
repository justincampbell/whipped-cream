require 'rack'
require 'dnssd'

module WhippedCream
  # A server handles building a plugin/runner and starting a web server
  class Server
    attr_reader :plugin, :options

    def initialize(plugin, options = {})
      @plugin = plugin
      @options = options
    end

    def start
      ensure_routes_built
      ensure_runner_started

      register_server
      start_web
    end

    def runner
      @runner ||= Runner.create_instance(plugin)
    end

    def web
      @web ||= Web
    end

    private

    def ensure_runner_started
      runner
    end

    def ensure_routes_built
      @routes_built ||= build_routes || true
    end

    def rack_options
      {
        app: web,
        Port: options.fetch(:port, 8080),
        daemonize: !!options[:daemonize]
      }
    end

    def start_web
      Rack::Server.start rack_options
    end

    def register_server
      name = runner.name || "<none>"
      service = "_whipped-cream._tcp"
      domain = nil
      port = rack_options[:Port]

      DNSSD.register(name, service, domain, port) do |reply|
        raise "Unable to register web server" unless reply.flags.add?
      end
    end

    def build_routes
      build_button_routes
      build_switch_routes
    end

    def build_button_routes
      plugin.buttons.each do |button|
        web.post "/#{button.id}" do
          runner.send button.id
          redirect to('/')
        end
      end
    end

    def build_switch_routes
      plugin.switches.each do |switch|
        web.post "/#{switch.id}" do
          runner.send switch.id, params[:state]
          redirect to('/')
        end
      end
    end
  end
end
