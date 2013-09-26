module WhippedCream
  # An abstract class for controls to inherit from
  class Control
    def id
      name.downcase.gsub(/[^\w]+/, '_').gsub(/^_|_$/, '').to_sym
    end
  end
end
