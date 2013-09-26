# Creates Plugin instances from a DSL
class WhippedCream::Builder
  def self.build(&block)
    builder = new(&block)
    builder.build
    builder.plugin
  end

  attr_reader :block

  def initialize(&block)
    @block = block
  end

  def build
    @build ||= instance_eval(&block)
  end

  def plugin
    @plugin ||= WhippedCream::Plugin.new
  end

  def button(name, pin: nil, &block)
    plugin.controls << WhippedCream::Button.new(name, pin: pin, block: block)
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
    plugin.controls << WhippedCream::Sensor.new(name, options, &block)
  end
end
