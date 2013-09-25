module WhippedCream
  # A Button represents a one-time action, such as momentarily turning on a
  # pin, or sending a message to an object
  class Button
    attr_reader :name, :pin, :block

    def initialize(name, pin: nil, block: nil)
      @name = name
      @pin = pin
      @block = block
    end

    def id
      name.downcase.gsub(/[^\w]+/, '_').gsub(/^_|_$/, '').to_sym
    end
  end
end
