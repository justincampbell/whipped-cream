# Data representation of a Plugin
class WhippedCream::Plugin
  attr_accessor :camera, :name

  def self.build(&block)
    WhippedCream::Builder.build(&block)
  end

  def controls
    @controls ||= []
  end

  def buttons
    controls.select { |control| control.is_a? WhippedCream::Button }
  end

  def fields
    controls.select { |control| control.is_a? WhippedCream::Field }
  end

  def sensors
    controls.select { |control| control.is_a? WhippedCream::Sensor }
  end

  def switches
    controls.select { |control| control.is_a? WhippedCream::Switch }
  end
end
