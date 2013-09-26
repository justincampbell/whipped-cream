module WhippedCream
  # Data representation of a Plugin
  class Plugin
    attr_accessor :camera, :name

    def self.build(&block)
      Builder.build(&block)
    end

    def controls
      @controls ||= []
    end

    def buttons
      controls.select { |control| control.is_a? Button }
    end

    def fields
      controls.select { |control| control.is_a? Field }
    end

    def sensors
      controls.select { |control| control.is_a? Sensor }
    end

    def switches
      controls.select { |control| control.is_a? Switch }
    end
  end
end
