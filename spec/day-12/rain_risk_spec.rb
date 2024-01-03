# frozen_string_literal: true

require './lib/day_12'

RSpec.describe 'Day 12: Rain Risk' do
  let(:test_data) do
    [
      'F10',
      'N3',
      'F7',
      'R90',
      'F11'
    ]
  end
  let(:fixture) { File.join fixtures_path, 'day_12.data' }
  let(:fixture_data) { [] }

  before do
    File.readlines(fixture).each do |line|
      fixture_data << line.chomp
    end
  end

  context 'Examples' do
    let(:model) { Day12.new test_data }

    it 'finds the Manhattan distance' do
      expect(model.exercise1).to eq 25
    end

    it 'finds the Manhattan distance' do
      expect(model.exercise2).to eq 286
    end
  end

  context 'Exercises' do
    let(:model) { Day12.new fixture_data }

    it 'finds the Manhattan distance' do
      expect(model.exercise1).to eq 562
    end

    it 'finds the Manhattan distance' do
      expect(model.exercise2).to eq 101860
    end
  end
end
