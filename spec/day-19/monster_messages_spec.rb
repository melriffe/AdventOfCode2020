# frozen_string_literal: true

require './lib/day_19'

RSpec.describe 'Day 19: Monster Messages' do
  let(:test_data) do
    [
      '0: 4 1 5',
      '1: 2 3 | 3 2',
      '2: 4 4 | 5 5',
      '3: 4 5 | 5 4',
      '4: "a"',
      '5: "b"',
      '',
      'ababbb',
      'bababa',
      'abbbab',
      'aaabbb',
      'aaaabbb'
    ]
  end
  let(:fixture) { File.join fixtures_path, 'day_19.data' }
  let(:fixture_data) { [] }

  before do
    File.readlines(fixture).each do |line|
      fixture_data << line.chomp
    end
  end

  context 'Examples' do
    let(:model) { Day19.new test_data }

    xit 'finds messages matching Rule 0' do
      expect(model.exercise1).to eq 2
    end
  end

  context 'Exercises' do
    let(:model) { Day19.new fixture_data }

  end
end
