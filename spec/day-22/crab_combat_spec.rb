# frozen_string_literal: true

require './lib/day_22'

RSpec.describe 'Day 22: Crab Combat' do
  let(:test_data) do
    [
      'Player 1:',
      '9',
      '2',
      '6',
      '3',
      '1',
      '',
      'Player 2:',
      '5',
      '8',
      '4',
      '7',
      '10'
    ]
  end
  let(:fixture) { File.join fixtures_path, 'day_22.data' }
  let(:fixture_data) { [] }

  before do
    File.readlines(fixture).each do |line|
      fixture_data << line.chomp
    end
  end

  context 'Examples' do
    let(:model) { Day22.new test_data }

    it "finds the winning player's score" do
      expect(model.exercise1).to eq 306
    end
  end

  context 'Exercises' do
    let(:model) { Day22.new fixture_data }

    it "finds the winning player's score" do
      expect(model.exercise1).to eq 33421
    end
  end
end
