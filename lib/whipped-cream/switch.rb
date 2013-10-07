module WhippedCream
  # A switch toggles a pin between on and off states
  class Switch < Control
    attr_reader :name, :pin

    def initialize(name, options = {})
      @name = name
      @pin = options[:pin]
    end
  end
end
