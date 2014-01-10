module WhippedCream
  # A switch toggles a pin between on and off states
  class Switch < Control
    attr_reader :name, :pin

    def initialize(name, options = {})
      raise "Invalid pin.  The pin must be one of "\
            "the Raspberry Pi's valid GPIO pins: "\
            "#{VALID_GPIO_PINS}" unless VALID_GPIO_PINS.include?(options[:pin])

      @name = name
      @pin = options[:pin]
    end
  end
end
