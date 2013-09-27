require 'sinatra'

module WhippedCream
  # A server handles building a plugin/runner and starting a web server
  class Server
    attr_reader :plugin

    def initialize(plugin)
      @plugin = plugin

      ensure_routes_built
      ensure_runner_started

      start_web
    end

    def runner
      @runner ||= Runner.create_instance(plugin)
    end

    def port
      8080
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

    def start_web
      Rack::Server.start app: web, port: port
    end

    def build_routes
      build_button_routes
    end

    def build_button_routes
      plugin.buttons.each do |button|
        web.get "/#{button.id}" do
          p :request, request
          p :runner, runner
          p :button, button
          runner.send(button.id)
        end
      end
    end

    class Web < Sinatra::Application
      def runner
        Runner.instance
      end
    end
  end
end
