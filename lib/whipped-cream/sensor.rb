require 'whipped-cream/control'

module WhippedCream
  # A Sensor displays the state of something, such as a pin's value, or the
  # return value of the method. Sensors can also have callbacks associated with
  # state changes.
  class Sensor < Control
    attr_reader :name, :pin, :low, :high, :on_low, :on_high, :block

    def initialize(name, options, &block)
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
