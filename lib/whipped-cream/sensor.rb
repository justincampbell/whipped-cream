require 'whipped-cream/control'

module WhippedCream
  # A Sensor displays the state of something, such as a pin's value, or the
  # return value of the method. Sensors can also have callbacks associated with
  # state changes.
  class Sensor < Control
    attr_reader :name, :pin, :low, :high, :on_low, :on_high, :block

    def initialize(name, pin: nil, low: nil, high: nil, on_low: nil, on_high: nil, &block)
      @name = name
      @pin = pin
      @low = low
      @high = high
      @on_low = on_low
      @on_high = on_high

      @block = block
    end
  end
end
