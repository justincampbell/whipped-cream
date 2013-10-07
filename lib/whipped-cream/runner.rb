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

      configure
    end

    def name
      plugin.name
    end

    def pins
      @pins ||= {}
    end

    private

    def configure
      configure_buttons
      configure_sensors
      configure_switches
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

    def configure_sensors
      plugin.sensors.each do |sensor|
        if sensor.pin
          define_sensor_method_with_pin sensor
        else
          define_sensor_method_with_block sensor
        end
      end
    end

    def define_sensor_method_with_pin(sensor)
      create_pin sensor, direction: :in

      define_singleton_method sensor.id do
        pin = pins[sensor.id]

        pin.value == 1 ? sensor.high : sensor.low
      end
    end

    def define_sensor_method_with_block(sensor)
      define_singleton_method sensor.id do
        sensor.block.call
      end
    end

    def configure_switches
      plugin.switches.each do |switch|
        create_pin switch, direction: :out

        define_singleton_method switch.id do
          pin = pins[switch.id]

          pin.value == 1 ? pin.off : pin.on
        end
      end
    end

    def create_pin(control, options = {})
      return unless control.pin

      options[:pin] = control.pin

      pins[control.id] = PiPiper::Pin.new(options)
    end
  end
end
