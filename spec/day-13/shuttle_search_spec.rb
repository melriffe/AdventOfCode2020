require './lib/day_13'

RSpec.describe 'Day 13: Shuttle Search' do
  let(:test_data) do
    [
      '939',
      '7,13,x,x,59,x,31,19'
    ]
  end
  let(:fixture) { File.join fixtures_path, 'day_13.data'}
  let(:fixture_data) { [] }

  before do
    File.readlines(fixture).each do |line|
      fixture_data << line.chomp
    end
  end

  context 'Examples' do
    let(:model) { Day13.new test_data }

    it 'finds number of minutes waiting' do
      expect(model.exercise1).to eq 295
    end
  end

  context 'Exercises' do
    let(:model) { Day13.new fixture_data }

    it 'finds number of minutes waiting' do
      expect(model.exercise1).to eq 3464
    end
  end
end
