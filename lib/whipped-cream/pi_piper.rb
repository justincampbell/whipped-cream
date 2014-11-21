# Fake PiPiper
module PiPiper
  # Just enough to imitate a pin
  class Pin
    attr_reader :pin, :direction

    def initialize(options)
      @pin = options[:pin]
      @direction = options[:direction]
    end

    def read
      @value ||= 0
    end

    def on
      @value = 1

      log "Pin #{pin} on"
    end

    def off
      @value = 0

      log "Pin #{pin} off"
    end

    private

    # :nocov:  Private methods should not count against %test coverage
    def log(message)
      puts message unless ENV['RUBY_ENV'] == 'test'
    end
    # :nocov:
  end
end
