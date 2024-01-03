# frozen_string_literal: true

require './lib/day_17'

RSpec.describe 'Day 17: Conway Cubes' do
  let(:test_data) do
    [
      '.#.',
      '..#',
      '###'
    ]
  end
  let(:fixture) { File.join fixtures_path, 'day_17.data' }
  let(:fixture_data) { [] }

  before do
    File.readlines(fixture).each do |line|
      fixture_data << line.chomp
    end
  end

  context 'Examples' do
    let(:model) { Day17.new test_data }

    xit 'finds number of active cubes' do
      expect(model.exercise1).to eq 112
    end
  end

  context 'Exercises' do
    let(:model) { Day17.new fixture_data }
  end
end
