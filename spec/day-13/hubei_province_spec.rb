# frozen_string_literal: true

require './lib/day_13'

RSpec.describe HubeiProvince do
  subject { described_class.new n, a }

  describe '#chinese_remainder' do
    let(:n) { [3, 5, 7] }
    let(:a) { [2, 3, 2] }

    it 'finds correct answer' do
      expect(subject.chinese_remainder).to eq 23
    end

    context 'with example data' do
      let(:n) { [7, 13, 59, 31, 19] }
      let(:a) { [0, 12, 55, 25, 12] }

      it 'finds correct answer' do
        expect(subject.chinese_remainder).to eq 1068781
      end
    end
  end
end
