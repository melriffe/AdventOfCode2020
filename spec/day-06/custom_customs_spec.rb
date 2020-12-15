require './lib/day_06'

RSpec.describe 'Day 6: Custom Customs' do
  let(:test_data) do
    [
      'abc',
      '',
      'a',
      'b',
      'c',
      '',
      'ab',
      'ac',
      '',
      'a',
      'a',
      'a',
      'a',
      '',
      'b'
    ]
  end
  let(:fixture) { File.join fixtures_path, 'day_06.data'}
  let(:fixture_data) { [] }

  before do
    File.readlines(fixture).each do |line|
      fixture_data << line.chomp
    end
  end

  context 'Examples' do
    let(:model) { Day06.new test_data }

    it 'finds sum of all yes answers' do
      expect(model.exercise1).to eq 11
    end

    it 'finds some of unique yes answers' do
      expect(model.exercise2).to eq 6
    end
  end

  context 'Exercises' do
    let(:model) { Day06.new fixture_data }

    it 'finds sum of all yes answers' do
      expect(model.exercise1).to eq 6521
    end

    it 'finds some of unique yes answers' do
      expect(model.exercise2).to eq 3305
    end
  end
end
