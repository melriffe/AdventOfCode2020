# frozen_string_literal: true
require './lib/day_15'

RSpec.describe 'Day 15: Rambunctious Recitation' do
  let(:test_data) do
    [
      '0,3,6'
    ]
  end
  let(:fixture) { File.join fixtures_path, 'day_15.data' }
  let(:fixture_data) { [] }

  before do
    File.readlines(fixture).each do |line|
      fixture_data << line.chomp
    end
  end

  context 'Examples' do
    let(:model) { Day15.new test_data }

    it 'finds 2020th number spoken' do
      expect(model.exercise1).to eq 436
    end

    it 'finds 30000000th number spoken' do
      expect(model.exercise2).to eq 175594
    end
  end

  context 'Exercises' do
    let(:model) { Day15.new fixture_data }

    it 'finds 2020th number spoken' do
      expect(model.exercise1).to eq 203
    end

    it 'finds 30000000th number spoken' do
      expect(model.exercise2).to eq 9007186
    end
  end
end
