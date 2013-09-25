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
        pin: button.pin,
        direction: :out
      }

      pins[button.id] = PiPiper::Pin.new(options)

      define_singleton_method button.id do
        pin = pins[button.id]

        pin.on
        sleep 0.25
        pin.off
      end
    end
  end
end
