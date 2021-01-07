# frozen_string_literal: true
require './lib/day_11'

RSpec.describe Position do
  before do
    PositionalLimits.max_col = 9
    PositionalLimits.max_row = 9
  end

  context 'when at 0,0' do
    let(:position) { described_class.new 0, 0 }

    context 'with #upper_left' do
      it 'returns expected column value' do
        expect(position.upper_left.column).to eq(-1)
      end

      it 'returns expected row value' do
        expect(position.upper_left.row).to eq(-1)
      end
    end

    context 'with #lower_right' do
      it 'returns expected column value' do
        expect(position.lower_right.column).to eq 1
      end

      it 'returns expected row value' do
        expect(position.lower_right.row).to eq 1
      end
    end
  end

  context 'as Hash key' do
    let(:positions) { {} }
    let(:key1) { described_class.new 0, 1 }
    let(:key2) { described_class.new 1, 0 }

    before do
      positions[key1] = 'hello'
      positions[key2] = 'world'
    end

    it 'returns expected value' do
      key = Position.new 0, 1
      expect(positions[key]).to eq 'hello'
    end

    it 'stores different value' do
      key = Position.new 1, 0
      positions[key] = 'TEST'
      expect(positions[key]).not_to eq 'world'
    end
  end
end
