require 'thor'

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
    def start(plugin_name)
      plugin_path = resolve_plugin(plugin_name)

      plugin = Plugin.from_file(plugin_path)
      server = Server.new(plugin)
      server.start(options)
    end

    no_tasks do
      def resolve_plugin(name)
        name # TODO: resolve name to filename
      end
    end
  end
end
