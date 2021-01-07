# frozen_string_literal: true
require './lib/day_05'

RSpec.describe BoardingPass do
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
