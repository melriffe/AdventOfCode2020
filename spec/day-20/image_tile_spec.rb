# frozen_string_literal: true

require './lib/day_20'

RSpec.describe ImageTile do

  subject { described_class.new id, data }

  let(:id) { '2311' }
  let(:data) do
    [
      '..##.#..#.',
      '##..#.....',
      '#...##..#.',
      '####.#...#',
      '##.##.###.',
      '##...#.###',
      '.#.#.#..##',
      '..#....#..',
      '###...#.#.',
      '..###..###'
    ]
  end

  let(:original_top)    { '..##.#..#.' }
  let(:original_right)  { '...#.##..#' }
  let(:original_bottom) { '..###..###' }
  let(:original_left)   { '.#####..#.' }

  describe '#border' do

    context 'with initial loading' do
      it 'captures top edge' do
        expect(subject.top).to eq original_top
      end

      it 'captures left edge' do
        expect(subject.left).to eq original_left
      end

      it 'captures bottom edge' do
        expect(subject.bottom).to eq original_bottom
      end

      it 'captures right edge' do
        expect(subject.right).to eq original_right
      end
    end

    context 'when rotating' do

      context 'with 1 rotation to the right' do
        before { subject.rotate_r }

        it 'has a new top edge' do
          expect(subject.top).to eq original_left
        end

        it 'has a new left edge' do
          expect(subject.left).to eq original_bottom
        end

        it 'has a new bottom edge' do
          expect(subject.bottom).to eq original_right
        end

        it 'has a new right edge' do
          expect(subject.right).to eq original_top
        end
      end

      context 'with 1 rotation to the left' do
        before { subject.rotate_l }

        it 'has a new top edge' do
          expect(subject.top).to eq original_right
        end

        it 'has a new left edge' do
          expect(subject.left).to eq original_top
        end

        it 'has a new bottom edge' do
          expect(subject.bottom).to eq original_left
        end

        it 'has a new right edge' do
          expect(subject.right).to eq original_bottom
        end
      end

      context 'with 2 rotations to the right' do
        before { 2.times { subject.rotate_r } }

        it 'has a new top edge' do
          expect(subject.top).to eq original_bottom
        end

        it 'has a new left edge' do
          expect(subject.left).to eq original_right
        end

        it 'has a new bottom edge' do
          expect(subject.bottom).to eq original_top
        end

        it 'has a new right edge' do
          expect(subject.right).to eq original_left
        end
      end

      context 'with 2 rotations to the left' do
        before { 2.times { subject.rotate_l } }

        it 'has a new top edge' do
          expect(subject.top).to eq original_bottom
        end

        it 'has a new left edge' do
          expect(subject.left).to eq original_right
        end

        it 'has a new bottom edge' do
          expect(subject.bottom).to eq original_top
        end

        it 'has a new right edge' do
          expect(subject.right).to eq original_left
        end
      end

      context 'with 3 rotations to the right' do
        before { 3.times { subject.rotate_r } }

        it 'has a new top edge' do
          expect(subject.top).to eq original_right
        end

        it 'has a new left edge' do
          expect(subject.left).to eq original_top
        end

        it 'has a new bottom edge' do
          expect(subject.bottom).to eq original_left
        end

        it 'has a new right edge' do
          expect(subject.right).to eq original_bottom
        end
      end

      context 'with 3 rotations to the left' do
        before { 3.times { subject.rotate_l } }

        it 'has a new top edge' do
          expect(subject.top).to eq original_left
        end

        it 'has a new left edge' do
          expect(subject.left).to eq original_bottom
        end

        it 'has a new bottom edge' do
          expect(subject.bottom).to eq original_right
        end

        it 'has a new right edge' do
          expect(subject.right).to eq original_top
        end
      end
    end

    context 'when flipping' do

      context 'on horizontal axis' do
        before { subject.flip_h }

        it 'has a new top edge' do
          expect(subject.top).to eq original_bottom
        end

        it 'has a different left edge' do
          expect(subject.left).to eq original_left.reverse
        end

        it 'has a new bottom edge' do
          expect(subject.bottom).to eq original_top
        end

        it 'has a different right edge' do
          expect(subject.right).to eq original_right.reverse
        end
      end

      context 'on vertical axis' do
        before { subject.flip_v }

        it 'has a different top edge' do
          expect(subject.top).to eq original_top.reverse
        end

        it 'has a new left edge' do
          expect(subject.left).to eq original_right
        end

        it 'has a different bottom edge' do
          expect(subject.bottom).to eq original_bottom.reverse
        end

        it 'has a new right edge' do
          expect(subject.right).to eq original_left
        end
      end
    end

    context 'with horizontal flip & right rotation' do
      before do
        subject.rotate_r.flip_h
      end

      it 'has a new top edge' do
        expect(subject.top).to eq original_right
      end

      it 'has a new left edge' do
        expect(subject.left).to eq original_bottom.reverse
      end

      it 'has a new bottom edge' do
        expect(subject.bottom).to eq original_left
      end

      it 'has a new right edge' do
        expect(subject.right).to eq original_top.reverse
      end
    end

    context 'with vertical flip & left rotation' do
      before do
        subject.rotate_l.flip_v
      end

      it 'has a new top edge' do
        expect(subject.top).to eq original_right.reverse
      end

      it 'has a new left edge' do
        expect(subject.left).to eq original_bottom
      end

      it 'has a new bottom edge' do
        expect(subject.bottom).to eq original_left.reverse
      end

      it 'has a new right edge' do
        expect(subject.right).to eq original_top
      end
    end

  end
end
