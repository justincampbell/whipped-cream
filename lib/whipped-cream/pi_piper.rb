# Fake PiPiper
module PiPiper
  # Just enough to imitate a pin
  class Pin
    attr_reader :pin, :direction, :value

    def initialize(options)
      @pin = options[:pin]
      @direction = options[:direction]
    end

    def on
      @value = :on

      log "Pin #{pin} on"
    end

    def off
      @value = :off

      log "Pin #{pin} off"
    end

    def log(message)
      puts message unless ENV['RUBY_ENV'] == 'test'
    end
  end
end
