require 'whipped-cream/control'

module WhippedCream
  # A Button represents a one-time action, such as momentarily turning on a
  # pin, or sending a message to an object
  class Button < Control
    attr_reader :name, :pin, :block

    def initialize(name, options = {})
      @name = name
      @pin = options[:pin]
      @block = options[:block]
    end
  end
end
