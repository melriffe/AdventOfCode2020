require './lib/day_03'

RSpec.describe 'Day 3: Toboggan Trajectory' do
  let(:test_data) do
    [
      '..##.......',
      '#...#...#..',
      '.#....#..#.',
      '..#.#...#.#',
      '.#...##..#.',
      '..#.##.....',
      '.#.#.#....#',
      '.#........#',
      '#.##...#...',
      '#...##....#',
      '.#..#...#.#',
    ]
  end
  let(:fixture) { File.join fixtures_path, 'day_03.data'}
  let(:fixture_data) { [] }

  before do
    File.readlines(fixture).each do |line|
      fixture_data << line.chomp
    end
  end

  context 'Examples' do
    let(:model) { Day03.new test_data }

    context 'with right 3 down 1 slope' do
      it 'hits some trees' do
        expect(model.exercise1).to eq 7
      end
    end

    context 'with multiple slopes' do
      it 'hits alot of trees' do
        expect(model.exercise2).to eq 336
      end
    end
  end

  context 'Exercises' do
    let(:model) { Day03.new fixture_data }

    context 'with right 3 down 1 slope' do
      it 'hits some trees' do
        expect(model.exercise1).to eq 294
      end
    end

    context 'with multiple slopes' do
      it 'hits alot of trees' do
        expect(model.exercise2).to eq 5774564250
      end
    end
  end
end
