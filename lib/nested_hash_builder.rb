module NestedHashBuilder
  def self.call(input)
    case input
    when Symbol
      { input => {} }
    when Array
      input.map { call(_1) }.reduce(:merge)
    when Hash
      input.transform_values { call(_1) }
    end
  end
end
