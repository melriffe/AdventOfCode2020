require './lib/day_14'

RSpec.describe 'Day 14: Docking Data' do
  let(:test_data) do
    [
      'mask = XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X',
      'mem[8] = 11',
      'mem[7] = 101',
      'mem[8] = 0'
    ]
  end
  let(:fixture) { File.join fixtures_path, 'day_14.data'}
  let(:fixture_data) { [] }

  before do
    File.readlines(fixture).each do |line|
      fixture_data << line.chomp
    end
  end

  context 'Examples' do
    let(:model) { Day14.new test_data }

    it 'finds sum of all values in memory' do
      expect(model.exercise1).to eq 165
    end
  end

  context 'Exercises' do
    let(:model) { Day14.new fixture_data }

    it 'finds sum of all values in memory' do
      expect(model.exercise1).to eq 15172047086292
    end
  end
end
