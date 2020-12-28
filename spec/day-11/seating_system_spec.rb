require './lib/day_11'

RSpec.describe 'Day 11: Seating System' do
  let(:test_data) do
    [
      'L.LL.LL.LL',
      'LLLLLLL.LL',
      'L.L.L..L..',
      'LLLL.LL.LL',
      'L.LL.LL.LL',
      'L.LLLLL.LL',
      '..L.L.....',
      'LLLLLLLLLL',
      'L.LLLLLL.L',
      'L.LLLLL.LL'
    ]
  end
  let(:fixture) { File.join fixtures_path, 'day_11.data'}
  let(:fixture_data) { [] }

  before do
    File.readlines(fixture).each do |line|
      fixture_data << line.chomp
    end
  end

  context 'Examples' do
    let(:model) { Day11.new test_data }

    it 'finds number of empty seats' do
      expect(model.exercise1).to eq 37
    end

    it 'finds number of empty seats' do
      expect(model.exercise2).to eq 26
    end
  end

  context 'Exercises' do
    let(:model) { Day11.new fixture_data }

    it 'finds number of empty seats' do
      expect(model.exercise1).to eq 2316
    end

    it 'finds number of empty seats' do
      expect(model.exercise2).to eq 2128
    end
  end

  describe Position do
    before do
      PositionalLimits.max_col = 9
      PositionalLimits.max_row = 9
    end

    context 'when at 0,0' do
      let(:position) { described_class.new 0, 0 }

      context 'with #upper_left' do
        it 'returns expected column value' do
          expect(position.upper_left.column).to eq -1
        end

        it 'returns expected row value' do
          expect(position.upper_left.row).to eq -1
        end
      end

      context 'with #lower_right' do
        it 'returns expected column value' do
          expect(position.lower_right.column).to eq 1
        end

        it 'returns expected row value' do
          expect(position.lower_right.row).to eq 1
        end
      end
    end

    context 'as Hash key' do
      let(:positions) { {} }
      let(:key1) { described_class.new 0, 1 }
      let(:key2) { described_class.new 1, 0 }

      before do
        positions[key1] = 'hello'
        positions[key2] = 'world'
      end

      it 'returns expected value' do
        key = Position.new 0, 1
        expect(positions[key]).to eq 'hello'
      end

      it 'stores different value' do
        key = Position.new 1, 0
        positions[key] = 'TEST'
        expect(positions[key]).not_to eq 'world'
      end
    end
  end

  describe SeatLayout do
    let(:seat_layout) { described_class.new test_data }

    context 'with adjacent transition logic' do
      before do
        SeatLayoutTransitionLogic.instance.adjacent_logic!
        count.times do
          seat_layout.analyze
          seat_layout.transition
        end
      end

      context 'after 1 round' do
        let(:count) { 1 }

        it 'has 71 occupied seats' do
          expect(seat_layout.occupied_seats).to eq 71
        end
      end

      context 'after 2 rounds' do
        let(:count) { 2 }

        it 'has 20 occupied seats' do
          expect(seat_layout.occupied_seats).to eq 20
        end
      end

      context 'after 3 rounds' do
        let(:count) { 3 }

        it 'has 51 occupied seats' do
          expect(seat_layout.occupied_seats).to eq 51
        end
      end

      context 'after 4 rounds' do
        let(:count) { 4 }

        it 'has 30 occupied seats' do
          expect(seat_layout.occupied_seats).to eq 30
        end
      end

      context 'after 5 rounds' do
        let(:count) { 5 }

        it 'has 37 occupied seats' do
          expect(seat_layout.occupied_seats).to eq 37
        end
      end
    end

    context 'with first seat transition logic' do
      before do
        SeatLayoutTransitionLogic.instance.first_seat_logic!
        count.times do
          seat_layout.analyze
          seat_layout.transition
        end
      end

      context 'after 1 round' do
        let(:count) { 1 }

        it 'has 71 occupied seats' do
          expect(seat_layout.occupied_seats).to eq 71
        end
      end

      context 'after 2 rounds' do
        let(:count) { 2 }

        it 'has 7 occupied seats' do
          expect(seat_layout.occupied_seats).to eq 7
        end
      end

      context 'after 3 rounds' do
        let(:count) { 3 }

        it 'has 53 occupied seats' do
          expect(seat_layout.occupied_seats).to eq 53
        end
      end

      context 'after 4 rounds' do
        let(:count) { 4 }

        it 'has 18 occupied seats' do
          expect(seat_layout.occupied_seats).to eq 18
        end
      end

      context 'after 5 rounds' do
        let(:count) { 5 }

        it 'has 31 occupied seats' do
          expect(seat_layout.occupied_seats).to eq 31
        end
      end

      context 'after 6 rounds' do
        let(:count) { 6 }

        it 'has 26 occupied seats' do
          expect(seat_layout.occupied_seats).to eq 26
        end
      end
    end

  end
end
