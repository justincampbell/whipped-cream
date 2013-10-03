begin
  require 'pi_piper'
rescue LoadError
  require 'whipped-cream/pi_piper'
end

module WhippedCream
  # Actor that manages all interaction with a plugin
  class Runner
    def self.instance
      @instance
    end

    def self.create_instance(plugin)
      @instance = new(plugin)
    end

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
        create_pin button, direction: :out

        define_singleton_method button.id do
          pin = pins[button.id]

          pin.on
          sleep 0.25
          pin.off
        end
      end
    end

    def create_pin(control, options = {})
      options[:pin] = control.pin

      pins[control.id] = PiPiper::Pin.new(options)
    end
  end
end
