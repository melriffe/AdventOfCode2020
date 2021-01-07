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

    context 'with different test_data' do
      let(:test_data) do
        [
          'mask = 000000000000000000000000000000X1001X',
          'mem[42] = 100',
          'mask = 00000000000000000000000000000000X0XX',
          'mem[26] = 1',
        ]
      end

      xit 'finds sum of all values in memory' do
        expect(model.exercise2).not_to be_zero
      end
    end
  end

  context 'Exercises' do
    let(:model) { Day14.new fixture_data }

    it 'finds sum of all values in memory' do
      expect(model.exercise1).to eq 15172047086292
    end
  end
end
