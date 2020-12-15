require './lib/day_05'

RSpec.describe 'Day 5: Binary Boarding' do
  let(:test_data) do
    [
      'FBFBBFFRLR', # row 44, column 5, seat ID 357
      'BFFFBBFRRR', # row 70, column 7, seat ID 567
      'FFFBBBFRRR', # row 14, column 7, seat ID 119
      'BBFFBBFRLL', # row 102, column 4, seat ID 820
    ]
  end
  let(:fixture) { File.join fixtures_path, 'day_05.data'}
  let(:fixture_data) { [] }

  before do
    File.readlines(fixture).each do |line|
      fixture_data << line.chomp
    end
  end

  context 'Examples' do
    let(:model) { Day05.new test_data }

    it 'finds highest seat ID' do
      expect(model.exercise1).to eq 820
    end
  end

  context 'with BoardingPass' do
    let(:bording_pass) { BoardingPass.new code }

    context 'when code is FBFBBFFRLR' do
      let(:code) { 'FBFBBFFRLR' }

      it 'returns 44 for row' do
        expect(bording_pass.row).to eq 44
      end

      it 'returns 5 for column' do
        expect(bording_pass.column).to eq 5
      end

      it 'returns 357 for seat id' do
        expect(bording_pass.seat_id).to eq 357
      end
    end
  end

  context 'Exercises' do
    let(:model) { Day05.new fixture_data }

    it 'finds highest seat ID' do
      expect(model.exercise1).to eq 838
    end
  end
end
