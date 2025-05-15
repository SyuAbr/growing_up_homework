# frozen_string_literal: true

class TransformCommand
  def initialize(input)
    @input = input
  end

  def call
    build_nested_hash(extract_paths(@input))
  end

  private

  def extract_paths(node, prefix = [], paths = [])
    case node
    when Symbol
      paths << (prefix + [node])
    when Hash
      node.each do |key, value|
        extract_paths(value, prefix + [key], paths)
      end
    when Array
      node.each do |element|
        extract_paths(element, prefix, paths)
      end
    end
    paths
  end

   def build_nested_hash(paths)
    {}.tap do |root|
      paths.each do |path|
        current = root
        path.each do |key|
          current[key] ||= {}
          current = current[key]
        end
      end
    end
  end
end
