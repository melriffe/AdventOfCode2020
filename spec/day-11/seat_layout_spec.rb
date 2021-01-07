# frozen_string_literal: true
require './lib/day_11'

RSpec.describe SeatLayout do
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
