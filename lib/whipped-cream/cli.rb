require 'thor'

module WhippedCream
  # The CLI gets invoked from the binary, and encapsulates all user interaction
  # logic
  class CLI < Thor
    default_task :usage

    desc "usage", "Display usage banner", hide: true
    def usage
      puts [
        "whipped-cream #{WhippedCream::VERSION}",
        "https://github.com/justincampbell/whipped-cream"
      ].join("\n")

      puts "\n"

      help
    end

    desc "PLUGIN", "Start a plugin"
    def start(plugin_name)
      plugin_path = resolve_plugin(plugin_name)

      plugin = Plugin.from_file(plugin_path)
      server = Server.new(plugin)
    end

    no_tasks do
      def resolve_plugin(name)
        name # TODO: resolve name to filename
      end
    end
  end
end
