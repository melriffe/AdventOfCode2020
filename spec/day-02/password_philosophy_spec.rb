require './lib/day_02'

RSpec.describe 'Day 2: Password Philosophy' do
  let(:test_data) { ['1-3 a: abcde', '1-3 b: cdefg', '2-9 c: ccccccccc' ] }
  let(:fixture) { File.join fixtures_path, 'day_02.data'}
  let(:fixture_data) { [] }

  before do
    File.readlines(fixture).each do |line|
      fixture_data << line.chomp
    end
  end

  context 'Examples' do
    let(:model) { Day02.new test_data }

    it 'finds valid passwords' do
      expect(model.exercise1).to eq 2
    end

    it 'finds actual valid passwords' do
      expect(model.exercise2).to eq 1
    end
  end

  context 'Exercises' do
    let(:model) { Day02.new fixture_data }

    it 'finds valid passwords' do
      expect(model.exercise1).to eq 383
    end

    it 'finds actual valid passwords' do
      expect(model.exercise2).to eq 706
    end
  end
end