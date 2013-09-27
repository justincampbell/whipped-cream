module WhippedCream
  # Creates Plugin instances from a DSL
  class Builder
    def self.build(&block)
      builder = new(&block)
      builder.build
      builder.plugin
    end

    def self.from_file(path)
      contents = File.read(path)

      from_string(contents)
    end

    def self.from_string(string)
      builder = new(string)
      builder.build
      builder.plugin
    end

    attr_reader :block, :string

    def initialize(string = nil, &block)
      @block = block
      @string = string
    end

    def build
      @build ||= string ?
        instance_eval(string) :
        instance_eval(&block)
    end

    def plugin
      @plugin ||= Plugin.new
    end

    def button(name, pin: nil, &block)
      plugin.controls << Button.new(name, pin: pin, block: block)
    end

    def camera
      plugin.camera = true
    end

    def helpers(&block)
      plugin.instance_eval(&block)
    end

    def name(string)
      plugin.name = string
    end

    def sensor(name, options = {}, &block)
      plugin.controls << Sensor.new(name, options, &block)
    end
  end
end
