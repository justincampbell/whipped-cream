# Fake PiPiper
module PiPiper
  # Just enough to imitate a pin
  class Pin
    attr_reader :pin, :direction

    def initialize(options)
      @pin = options[:pin]
      @direction = options[:direction]
    end

    def on; end
    def off; end
  end
end
