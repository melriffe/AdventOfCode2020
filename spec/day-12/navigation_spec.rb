require './lib/day_12'

RSpec.describe Navigation do

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
