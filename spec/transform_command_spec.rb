# frozen_string_literal: true

require_relative '../lib/transform_command'

RSpec.describe TransformCommand, '#call' do
  subject(:result) { described_class.new(input).call }

  context  do
    let(:input) do
      {
        a: :a1,
        b: [:b1, :b2],
        c: { c1: :c2 },
        d: [:d1, [:d2, :d3], { d4: :d5 }],
        e: { e1: { e2: :e3 }, e4: [:e5, :e6] }
      }
    end

    let(:expected) do
      {
        a:   { a1: {} },
        b:   { b1: {}, b2: {} },
        c:   { c1: { c2: {} } },
        d:   { d1: {}, d2: {}, d3: {}, d4: { d5: {} } },
        e:   { e1: { e2: { e3: {} } }, e4: { e5: {}, e6: {} } }
      }
    end

    it 'builds the correct nested hash' do
      expect(result).to eq(expected)
    end
  end
end
