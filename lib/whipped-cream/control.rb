module WhippedCream
  # An abstract class for controls to inherit from
  class Control
    VALID_GPIO_PINS = [4, 17, 18, 22, 23, 24, 25, 27]

    def id
      name.downcase.gsub(/[^\w]+/, '_').gsub(/^_|_$/, '').to_sym
    end

    def type
      self.class.to_s.split('::').last.downcase.to_sym
    end
  end
end
