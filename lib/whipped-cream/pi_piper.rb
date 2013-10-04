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

      p self
    end

    def off
      @value = :off

      p self
    end
  end
end
