require './lib/day_12'

RSpec.describe 'Day 12: Rain Risk' do
  let(:test_data) do
    [
      'F10',
      'N3',
      'F7',
      'R90',
      'F11'
    ]
  end
  let(:fixture) { File.join fixtures_path, 'day_12.data'}
  let(:fixture_data) { [] }

  before do
    File.readlines(fixture).each do |line|
      fixture_data << line.chomp
    end
  end

  context 'Examples' do
    let(:model) { Day12.new test_data }

    it 'finds the Manhattan distance' do
      expect(model.exercise1).to eq 25
    end
  end

  context 'Exercises' do
    let(:model) { Day12.new fixture_data }

    it 'finds the Manhattan distance' do
      expect(model.exercise1).to eq 562
    end

  end

  describe Facing do
    subject { described_class.new test_key }

    context 'with intial facing of :east' do
      let(:test_key) { 0 }

      it 'faces east' do
        expect(subject.direction).to eq :east
      end

      context 'when turning left' do

        it 'faces north with 1 turn' do
          subject.turn_left 1
          expect(subject.direction).to eq :north
        end

        it 'faces west with 2 turns' do
          subject.turn_left 2
          expect(subject.direction).to eq :west
        end

        it 'faces south with 3 turns' do
          subject.turn_left 3
          expect(subject.direction).to eq :south
        end
      end

      context 'when turning right' do

        it 'faces south with 1 turn' do
          subject.turn_right 1
          expect(subject.direction).to eq :south
        end

        it 'faces west with 2 turns' do
          subject.turn_right 2
          expect(subject.direction).to eq :west
        end

        it 'faces north with 3 turns' do
          subject.turn_right 3
          expect(subject.direction).to eq :north
        end
      end
    end

    context 'with intial facing of :south' do
      let(:test_key) { 1 }

      it 'faces south' do
        expect(subject.direction).to eq :south
      end

      context 'when turning left' do

        it 'faces east with 1 turn' do
          subject.turn_left 1
          expect(subject.direction).to eq :east
        end

        it 'faces north with 2 turns' do
          subject.turn_left 2
          expect(subject.direction).to eq :north
        end

        it 'faces west with 3 turns' do
          subject.turn_left 3
          expect(subject.direction).to eq :west
        end
      end

      context 'when turning right' do

        it 'faces west with 1 turn' do
          subject.turn_right 1
          expect(subject.direction).to eq :west
        end

        it 'faces north with 2 turns' do
          subject.turn_right 2
          expect(subject.direction).to eq :north
        end

        it 'faces east with 3 turns' do
          subject.turn_right 3
          expect(subject.direction).to eq :east
        end
      end
    end

    context 'with intial facing of :west' do
      let(:test_key) { 2 }

      it 'faces west' do
        expect(subject.direction).to eq :west
      end

      context 'when turning left' do

        it 'faces south with 1 turn' do
          subject.turn_left 1
          expect(subject.direction).to eq :south
        end

        it 'faces east with 2 turns' do
          subject.turn_left 2
          expect(subject.direction).to eq :east
        end

        it 'faces north with 3 turns' do
          subject.turn_left 3
          expect(subject.direction).to eq :north
        end
      end

      context 'when turning right' do

        it 'faces north with 1 turn' do
          subject.turn_right 1
          expect(subject.direction).to eq :north
        end

        it 'faces east with 2 turns' do
          subject.turn_right 2
          expect(subject.direction).to eq :east
        end

        it 'faces south with 3 turns' do
          subject.turn_right 3
          expect(subject.direction).to eq :south
        end
      end
    end

    context 'with intial facing of :north' do
      let(:test_key) { 3 }

      it 'faces north' do
        expect(subject.direction).to eq :north
      end

      context 'when turning left' do

        it 'faces west with 1 turn' do
          subject.turn_left 1
          expect(subject.direction).to eq :west
        end

        it 'faces south with 2 turns' do
          subject.turn_left 2
          expect(subject.direction).to eq :south
        end

        it 'faces east with 3 turns' do
          subject.turn_left 3
          expect(subject.direction).to eq :east
        end
      end

      context 'when turning right' do

        it 'faces east with 1 turn' do
          subject.turn_right 1
          expect(subject.direction).to eq :east
        end

        it 'faces south with 2 turns' do
          subject.turn_right 2
          expect(subject.direction).to eq :south
        end

        it 'faces west with 3 turns' do
          subject.turn_right 3
          expect(subject.direction).to eq :west
        end
      end
    end

  end

  describe Location do
    let(:test_facing) { Facing.new }
    subject { described_class.new test_facing }

    context '#manhattan_distance' do
      before do
        subject.east 17
        subject.south 8
      end

      it 'calculates correct value' do
        expect(subject.manhattan_distance).to eq 25
      end
    end

    context 'when testing movement' do
      context 'with north-south movement' do
        it 'finishes with correct values' do
          expect(subject.south_units).to be_zero
          expect(subject.north_units).to be_zero

          subject.south 5
          expect(subject.south_units).to eq 5
          expect(subject.north_units).to be_zero

          subject.north 2
          expect(subject.south_units).to eq 3
          expect(subject.north_units).to be_zero

          subject.north 3
          expect(subject.south_units).to be_zero
          expect(subject.north_units).to be_zero

          subject.north 3
          expect(subject.south_units).to be_zero
          expect(subject.north_units).to eq 3

          subject.south 11
          expect(subject.south_units).to eq 8
          expect(subject.north_units).to be_zero
        end
      end

      context 'with east-west movement' do
        before do
          subject.west 2
          subject.west 1
          subject.west 4
          subject.east 2
        end

        it 'has a zero east value' do
          expect(subject.east_units).to be_zero
        end

        it 'has a five west value' do
          expect(subject.west_units).to eq 5
        end
      end
    end
  end
end
