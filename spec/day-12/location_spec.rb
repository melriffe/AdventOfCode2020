require './lib/day_12'

RSpec.describe Location do
  describe '#manhattan_distance' do
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
