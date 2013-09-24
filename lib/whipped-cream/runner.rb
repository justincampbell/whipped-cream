begin
  require 'pi_piper'
rescue LoadError
  require 'whipped-cream/pi_piper'
end


# Actor that manages all interaction with a plugin
class WhippedCream::Runner
  attr_reader :plugin

  def initialize(plugin)
    @plugin = plugin

    start
  end

  def name
    plugin.name
  end

  def pins
    @pins ||= {}
  end

  private

  def start
    configure_buttons
  end

  def configure_buttons
    plugin.buttons.each do |button|
      options = {
        pin: button[:pin],
        direction: :out
      }

      button_name = name_to_symbol(button[:name])

      pins[button_name] = PiPiper::Pin.new(options)

      define_singleton_method button_name do
        pins[button_name].on
        sleep 0.25
        pins[button_name].off
      end
    end
  end

  def name_to_symbol(string)
    string.to_s.downcase.gsub(/[^\w]+/, '_').gsub(/^-|-$/, '').to_sym
  end
end
