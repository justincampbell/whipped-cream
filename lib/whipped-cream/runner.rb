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

    def read_pin(pin)
      pin.read.zero? ? :off : :on
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
          tap_pin(pins[button.id])
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

        read_pin(pin) == :on ? sensor.high : sensor.low
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

        define_singleton_method switch.id do |state|
          set_pin(pins[switch.id], state)
        end
      end
    end

    def create_pin(control, options = {})
      return unless control.pin

      options[:pin] = control.pin

      pins[control.id] = PiPiper::Pin.new(options)
    end

    def tap_pin(pin)
      set_pin(pin, :on)

      Thread.new {
        sleep 0.25
        set_pin(pin, :off)
      }
    end

    def set_pin(pin, state)
      return if read_pin(pin) == state

      pin.send(state)
    end
  end
end
