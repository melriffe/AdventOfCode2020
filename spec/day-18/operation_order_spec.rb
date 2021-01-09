# frozen_string_literal: true
require './lib/day_18'

RSpec.describe 'Day 18: Operation Order' do
  let(:test_data) do
    [
      '1 + 2 * 3 + 4 * 5 + 6',                            #    71 |    231
      '1 + (2 * 3) + (4 * (5 + 6))',                      #    51 |     51
      '2 * 3 + (4 * 5)',                                  #    26 |     46
      '5 + (8 * 3 + 9 + 3 * 4 * 3)',                      #   237 |   1445
      '5 * 9 * (7 * 3 * 3 + 9 * 3 + (8 + 6 * 4))',        # 12240 | 669060
      '((2 + 4 * 9) * (6 + 9 * 8 + 6) + 6) + 2 + 4 * 2',  # 13632 |  23340
    ]
  end
  let(:fixture) { File.join fixtures_path, 'day_18.data' }
  let(:fixture_data) { [] }

  before do
    File.readlines(fixture).each do |line|
      fixture_data << line.chomp
    end
  end

  context 'Examples' do
    let(:model) { Day18.new test_data }

    it 'finds sum of resulting values' do
      expect(model.exercise1).to eq 26457
    end

    xit 'finds sum of advanced-math values' do
      expect(model.exercise2).to eq 694173
    end
  end

  context 'Exercises' do
    let(:model) { Day18.new fixture_data }

    it 'finds sum of resulting values' do
      expect(model.exercise1).to eq 6923486965641
    end
  end
end
