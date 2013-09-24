# Data representation of a Plugin
class WhippedCream::Plugin
  attr_accessor :camera, :name

  def self.build(&block)
    WhippedCream::Builder.build(&block)
  end

  def buttons
    @buttons ||= []
  end

  def fields
    @fields ||= []
  end

  def sensors
    @sensors ||= []
  end

  def switches
    @switches ||= []
  end
end
