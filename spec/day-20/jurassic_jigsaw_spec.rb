# frozen_string_literal: true

require './lib/day_20'

RSpec.describe 'Day 20: Jurassic Jigsaw' do
  let(:test_data) do
    []
  end
  let(:fixture) { File.join fixtures_path, 'day_20.data' }
  let(:fixture_data) { [] }

  before do
    File.readlines(fixture).each do |line|
      fixture_data << line.chomp
    end
  end

  context 'Examples' do
    let(:test_fixture) { File.join fixtures_path, 'day_20_test.data' }
    let(:model) { Day20.new test_data }

    before do
      File.readlines(test_fixture).each do |line|
        test_data << line.chomp
      end
    end

    it 'locates corner tiles of assembled image' do
      expect(model.exercise1).to eq 20899048083289
    end
  end

  context 'Exercises' do
    let(:model) { Day20.new fixture_data }

    it 'locates corner tiles of assembled image' do
      expect(model.exercise1).to eq 111936085519519
    end
  end
end
