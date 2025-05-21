# frozen_string_literal: true

require_relative '../lib/nested_hash_builder'

RSpec.describe NestedHashBuilder do
  subject(:result) { described_class.call(input) }

  context 'when input is a deeply nested hybrid structure' do
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

    it 'returns the correctly nested hash structure' do
      expect(result).to eq(expected)
    end
  end
end
