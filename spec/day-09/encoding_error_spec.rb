require './lib/day_09'

RSpec.describe 'Day 9: Encoding Error' do
  let(:test_data) do
    [
      '35',
      '20',
      '15',
      '25',
      '47',
      '40',
      '62',
      '55',
      '65',
      '95',
      '102',
      '117',
      '150',
      '182',
      '127',
      '219',
      '299',
      '277',
      '309',
      '576'
    ]
  end
  let(:fixture) { File.join fixtures_path, 'day_09.data'}
  let(:fixture_data) { [] }

  before do
    File.readlines(fixture).each do |line|
      fixture_data << line.chomp
    end
  end

  context 'Examples' do
    let(:model) { Day09.new test_data }

    it 'finds first number that breaks XMAS cypher' do
      expect(model.exercise1 preamble: 5).to eq 127
    end
  end

  context 'Exercises' do
    let(:model) { Day09.new fixture_data }

    it 'finds first number that breaks XMAS cypher' do
      expect(model.exercise1 preamble: 25).to eq 1721308972
    end
  end
end
