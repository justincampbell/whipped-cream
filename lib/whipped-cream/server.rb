module WhippedCream
  class Server
    attr_reader :plugin

    def initialize(plugin)
      @plugin = plugin
      ensure_runner_started
    end

    def runner
      @runner ||= Runner.new(plugin)
    end

    private

    def ensure_runner_started
      runner
    end
  end
end
