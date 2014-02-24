require 'thor'
require 'dnssd'

module WhippedCream
  # The CLI gets invoked from the binary, and encapsulates all user interaction
  # logic
  class CLI < Thor
    default_task :usage

    desc "usage", "Display usage banner", hide: true
    def usage
      puts [
        "Whipped Cream #{WhippedCream::VERSION}",
        "https://github.com/justincampbell/whipped-cream"
      ].join("\n")

      puts "\n"

      help
    end

    desc "demo", "Start the demo plugin"
    def demo
      plugin = Plugin.from_file(File.expand_path('../../../demo.rb', __FILE__))
      server = Server.new(plugin)
      server.start
    end

    desc "deploy PLUGIN IP", "Deploy a plugin to a Pi"
    def deploy(plugin_name, pi_address)
      plugin_path = resolve_plugin(plugin_name)

      deployer = Deployer.new(plugin_path, pi_address)
      deployer.deploy
    end

    desc "start PLUGIN", "Start a plugin"
    method_option :daemonize,
      type: :boolean,
      desc: "Run the server in the background"
    method_option :port,
      desc: "Choose a different port to run the server on"
    def start(plugin_name)
      plugin_path = resolve_plugin(plugin_name)

      plugin = Plugin.from_file(plugin_path)
      server = Server.new(plugin, options)
      server.start
    end

    desc "discover", "Discovers any whipped-cream servers on the local network"
    def discover
      services = browse_services('_whipped-cream._tcp.')

      services.each do |service|
        host = resolve_service(service)

        puts "#{host[:address]}:#{host[:port]}\t#{host[:name]}"
      end

      services
    end

    no_tasks do
      def resolve_plugin(name)
        name += '.rb' unless name.split('.').last == 'rb'
        name
      end

      def browse_services(service_type)
        services = []

        begin
          timeout 5 do
            DNSSD::Service.new.browse(service_type) do |reply|
              services << reply if reply.flags.add?
              break unless reply.flags.more_coming?
            end
          end
        rescue Timeout::Error
          log "ERROR: #browse_services took more than 5 seconds."
        end

        services
      end

      def resolve_service(service)
        host = {}

        begin
          timeout 5 do
            DNSSD::Service.new.resolve(service) do |reply|
              address = get_ipv4_address(reply)

              host[:name]    = "#{reply.name}"
              host[:address] = "#{address}"
              host[:port]    = "#{reply.port}"
              break unless reply.flags.more_coming?
            end
          end
        rescue Timeout::Error
          log "ERROR: #resolve_service took more than 5 seconds."
        end

        host
      end

      def get_ipv4_address(reply)
        address = nil

        begin
          timeout 5 do
            DNSSD::Service.new.getaddrinfo(reply.target, 1) do |addrinfo|
              address = addrinfo.address
              break unless addrinfo.flags.more_coming?
            end
          end
        rescue Timeout::Error
          log "ERROR: #get_ipv4_address took more than 5 seconds."
        end

        address
      end
    end
  end
end
