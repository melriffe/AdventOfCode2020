require './lib/day_10'

RSpec.describe 'Day 10: Adapter Array' do
  let(:test_data) do
    [
      '28',
      '33',
      '18',
      '42',
      '31',
      '14',
      '46',
      '20',
      '48',
      '47',
      '24',
      '23',
      '49',
      '45',
      '19',
      '38',
      '39',
      '11',
      '1',
      '32',
      '25',
      '35',
      '8',
      '17',
      '7',
      '9',
      '4',
      '2',
      '34',
      '10',
      '3',
    ]
  end
  let(:fixture) { File.join fixtures_path, 'day_10.data'}
  let(:fixture_data) { [] }

  before do
    File.readlines(fixture).each do |line|
      fixture_data << line.chomp
    end
  end

  context 'Examples' do
    let(:model) { Day10.new test_data }

    it 'finds product of 1-jolt and 3-jolt differences' do
      expect(model.exercise1).to eq 220
    end

    it 'finds count of distinct adapter arrangements' do
      expect(model.exercise2).to eq 19208
    end
  end

  context 'Exercises' do
    let(:model) { Day10.new fixture_data }

    it 'finds product of 1-jolt and 3-jolt differences' do
      expect(model.exercise1).to eq 1904
    end

    it 'finds count of distinct adapter arrangements' do
      expect(model.exercise2).to eq 10578455953408
    end
  end
end
