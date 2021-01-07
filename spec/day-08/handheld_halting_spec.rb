require './lib/day_08'

RSpec.describe 'Day 8: Handheld Halting' do
  let(:test_data) do
    [
      'nop +0',
      'acc +1',
      'jmp +4',
      'acc +3',
      'jmp -3',
      'acc -99',
      'acc +1',
      'jmp -4',
      'acc +6',
    ]
  end
  let(:fixture) { File.join fixtures_path, 'day_08.data' }
  let(:fixture_data) { [] }

  before do
    File.readlines(fixture).each do |line|
      fixture_data << line.chomp
    end
  end

  context 'Examples' do
    let(:model) { Day08.new test_data }

    it 'finds value of accumulator before infinite loop' do
      expect(model.exercise1).to eq 5
    end

    it 'finds value of accumulator after fixing instruction' do
      expect(model.exercise2).to eq 8
    end
  end

  context 'Exercises' do
    let(:model) { Day08.new fixture_data }

    it 'finds value of accumulator before infinite loop' do
      expect(model.exercise1).to eq 1797
    end

    it 'finds value of accumulator after fixing instruction' do
      expect(model.exercise2).to eq 1036
    end
  end
end
