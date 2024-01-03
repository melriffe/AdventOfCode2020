# frozen_string_literal: true

require './lib/day_12'

RSpec.describe Waypoint do
  context 'Initial Location' do
    it 'starts at 10 units east' do
      expect(subject.east_units).to eq 10
    end

    it 'starts at 1 unit north' do
      expect(subject.north_units).to eq 1
    end
  end

  context 'Turing Right' do
    context 'rotating 1 step' do
      before { subject.rotate_right 1 }

      it 'has a 1 for east units' do
        expect(subject.east_units).to eq 1
      end

      it 'has a 10 for south units' do
        expect(subject.south_units).to eq 10
      end
    end

    context 'rotating 2 steps' do
      before { subject.rotate_right 2 }

      it 'has a 10 for west units' do
        expect(subject.west_units).to eq 10
      end

      it 'has a 1 for south units' do
        expect(subject.south_units).to eq 1
      end
    end

    context 'rotating 3 steps' do
      before { subject.rotate_right 3 }

      it 'has a 1 for west units' do
        expect(subject.west_units).to eq 1
      end

      it 'has a 10 for north units' do
        expect(subject.north_units).to eq 10
      end
    end
  end

  context 'Turning Left' do
    context 'rotating 1 step' do
      before { subject.rotate_left 1 }

      it 'has a 1 for west units' do
        expect(subject.west_units).to eq 1
      end

      it 'has a 10 for north units' do
        expect(subject.north_units).to eq 10
      end
    end

    context 'rotating 2 steps' do
      before { subject.rotate_left 2 }

      it 'has a 10 for west units' do
        expect(subject.west_units).to eq 10
      end

      it 'has a 1 for south units' do
        expect(subject.south_units).to eq 1
      end
    end

    context 'rotating 3 steps' do
      before { subject.rotate_left 3 }

      it 'has a 1 for east units' do
        expect(subject.east_units).to eq 1
      end

      it 'has a 10 for south units' do
        expect(subject.south_units).to eq 10
      end
    end
  end

  context 'Moving Waypoint' do
    before do
      subject.west 12
    end

    it 'is at 2 unit west' do
      expect(subject.west_units).to eq 2
    end

    it 'is at 1 unit north' do
      expect(subject.north_units).to eq 1
    end

    context 'Turning Right' do
      context 'rotating 1 step' do
        before { subject.rotate_right 1 }

        it 'has a 1 for east units' do
          expect(subject.east_units).to eq 1
        end

        it 'has a 2 for north units' do
          expect(subject.north_units).to eq 2
        end
      end

      context 'rotating 2 steps' do
        before { subject.rotate_right 2 }

        it 'has a 2 for east units' do
          expect(subject.east_units).to eq 2
        end

        it 'has a 1 for south units' do
          expect(subject.south_units).to eq 1
        end
      end

      context 'rotating 3 steps' do
        before { subject.rotate_right 3 }

        it 'has a 1 for west units' do
          expect(subject.west_units).to eq 1
        end

        it 'has a 2 for south units' do
          expect(subject.south_units).to eq 2
        end
      end
    end

    context 'Turning Left' do
      context 'rotating 1 step' do
        before { subject.rotate_left 1 }

        it 'has a 1 for west units' do
          expect(subject.west_units).to eq 1
        end

        it 'has a 2 for south units' do
          expect(subject.south_units).to eq 2
        end
      end

      context 'rotating 2 steps' do
        before { subject.rotate_left 2 }

        it 'has a 2 for east units' do
          expect(subject.east_units).to eq 2
        end

        it 'has a 1 for south units' do
          expect(subject.south_units).to eq 1
        end
      end

      context 'rotating 3 steps' do
        before { subject.rotate_left 3 }

        it 'has a 1 for east units' do
          expect(subject.east_units).to eq 1
        end

        it 'has a 2 for north units' do
          expect(subject.north_units).to eq 2
        end
      end
    end
  end
end
