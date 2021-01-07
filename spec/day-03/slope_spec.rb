# frozen_string_literal: true
require './lib/day_03'

RSpec.describe Slope do
  let(:test_data) do
    [
      '..##.......',
      '#...#...#..',
      '.#....#..#.',
      '..#.#...#.#',
      '.#...##..#.',
      '..#.##.....',
      '.#.#.#....#',
      '.#........#',
      '#.##...#...',
      '#...##....#',
      '.#..#...#.#'
    ]
  end

  context 'Samples' do
    let(:model) { Day03.new test_data }

    context 'with right 1 down 1 slope' do
      it 'hits some trees' do
        slope = Slope.new right: 1
        expect(model.exercise1(slope)).to eq 2
      end
    end

    context 'with right 5 down 1 slope' do
      it 'hits some trees' do
        slope = Slope.new right: 5
        expect(model.exercise1(slope)).to eq 3
      end
    end

    context 'with right 7 down 1 slope' do
      it 'hits some trees' do
        slope = Slope.new right: 7
        expect(model.exercise1(slope)).to eq 4
      end
    end

    context 'with right 1 down 2 slope' do
      it 'hits some trees' do
        slope = Slope.new down: 2
        expect(model.exercise1(slope)).to eq 2
      end
    end
  end
end
