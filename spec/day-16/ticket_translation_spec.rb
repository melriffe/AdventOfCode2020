require './lib/day_16'

RSpec.describe 'Day 16: Ticket Translation' do
  let(:test_data) do
    [
      'class: 1-3 or 5-7',
      'row: 6-11 or 33-44',
      'seat: 13-40 or 45-50',
      '',
      'your ticket:',
      '7,1,14',
      '',
      'nearby tickets:',
      '7,3,47',
      '40,4,50',
      '55,2,20',
      '38,6,12',
    ]
  end
  let(:fixture) { File.join fixtures_path, 'day_16.data' }
  let(:fixture_data) { [] }

  before do
    File.readlines(fixture).each do |line|
      fixture_data << line.chomp
    end
  end

  context 'Examples' do
    let(:model) { Day16.new test_data }

    it 'finds ticket scanning error rate' do
      expect(model.exercise1).to eq 71
    end

    xit 'finds departure fields on my ticket' do
      expect(model.exercise2).not_to be_zero
    end
  end

  context 'Exercises' do
    let(:model) { Day16.new fixture_data }

    it 'finds ticket scanning error rate' do
      expect(model.exercise1).to eq 25895
    end
  end
end
