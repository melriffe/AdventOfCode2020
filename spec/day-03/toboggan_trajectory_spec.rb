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

    context 'with right 1 down 1 slope' do
      it 'hits some trees' do
        slope = Slope.new right: 1
        expect(model.exercise1 slope).to eq 2
      end
    end

    context 'with right 5 down 1 slope' do
      it 'hits some trees' do
        slope = Slope.new right: 5
        expect(model.exercise1 slope).to eq 3
      end
    end

    context 'with right 7 down 1 slope' do
      it 'hits some trees' do
        slope = Slope.new right: 7
        expect(model.exercise1 slope).to eq 4
      end
    end

    context 'with right 1 down 2 slope' do
      it 'hits some trees' do
        slope = Slope.new down: 2
        expect(model.exercise1 slope).to eq 2
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

    context 'with right 1 down 1 slope' do
      it 'hits some trees' do
        slope = Slope.new right: 1
        expect(model.exercise1 slope).to eq 2
      end
    end

    xcontext 'with right 5 down 1 slope' do
      it 'hits some trees' do
        slope = Slope.new right: 5
        expect(model.exercise1 slope).to eq 3
      end
    end

    xcontext 'with right 7 down 1 slope' do
      it 'hits some trees' do
        slope = Slope.new right: 7
        expect(model.exercise1 slope).to eq 4
      end
    end

    xcontext 'with right 1 down 2 slope' do
      it 'hits some trees' do
        slope = Slope.new down: 2
        expect(model.exercise1 slope).to eq 2
      end
    end

    xcontext 'with multiple slopes' do
      it 'hits alot of trees' do
        expect(model.exercise2).to eq 5478432750
        # your answer is too low
      end
    end
  end
end