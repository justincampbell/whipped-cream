# Parses a plugin file and exposes data about the plugin
class WhippedCream::Plugin
  attr_accessor :final

  def self.build(&block)
    plugin = new
    plugin.instance_eval(&block) if block_given?
    plugin.finalize
    plugin
  end

  def button(name, options = {}, &block)
    if final
      buttons.find { |hash| hash[:name] == name }
    else
      buttons << { name: name, block: block }.merge(options)
    end
  end

  def buttons
    @buttons ||= []
  end

  def camera
    final ? @camera : @camera = true
  end

  def name(value = nil)
    @name ||= value
  end

  def finalize
    self.final = true
  end
end
