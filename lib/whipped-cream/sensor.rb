require 'whipped-cream/control'

module WhippedCream
  # A Sensor displays the state of something, such as a pin's value, or the
  # return value of the method. Sensors can also have callbacks associated with
  # state changes.
  class Sensor < Control
    attr_reader :name, :pin, :low, :high, :on_low, :on_high, :block

    def initialize(name, options = {}, &block)
      # Pushing nil onto VALID_GPIO_PINS to allow a pinless sensor
      raise "Invalid pin.  The pin must be one of "\
            "the Raspberry Pi's valid GPIO pins: "\
            "#{VALID_GPIO_PINS}" unless VALID_GPIO_PINS.dup
                                                       .push(nil)
                                                       .include?(options[:pin])

      @name = name
      @pin = options[:pin]
      @low = options[:low]
      @high = options[:high]
      @on_low = options[:on_low]
      @on_high = options[:on_high]

      @block = block
    end
  end
end
