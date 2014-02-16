require 'whipped-cream/control'

module WhippedCream
  # A Button represents a one-time action, such as momentarily turning on a
  # pin, or sending a message to an object
  class Button < Control
    attr_reader :name, :pin, :duration, :block

    def initialize(name, options = {})
      raise "Invalid pin.  The pin must be one of "\
            "the Raspberry Pi's valid GPIO pins: "\
            "#{VALID_GPIO_PINS}" unless VALID_GPIO_PINS.include?(options[:pin])

      @name = name
      @pin = options[:pin]
      @duration = options[:duration] || 0.25
      @block = options[:block]
    end
  end
end
