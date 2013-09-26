require 'whipped-cream/control'

module WhippedCream
  # A Button represents a one-time action, such as momentarily turning on a
  # pin, or sending a message to an object
  class Button < Control
    attr_reader :name, :pin, :block

    def initialize(name, pin: nil, block: nil)
      @name = name
      @pin = pin
      @block = block
    end
  end
end
