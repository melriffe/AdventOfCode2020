require './lib/day_01'

RSpec.describe "Report Repair" do
  let(:test_data) { [1721, 979, 366, 299, 675, 1456] }
  let(:fixture) { File.join fixtures_path, 'day_01.data'}
  let(:fixture_data) { [] }

  before do
    File.readlines(fixture).each do |line|
      fixture_data << line.chomp.to_i
    end
  end

  context 'Example 1' do
    let(:model) { Day01.new test_data }

    it 'finds pair that equals 2020' do
      expect(model.exercise1).to eq 514579
    end

    it 'finds trio that equals 2020' do
      expect(model.exercise2).to eq 241861950
    end
  end

  context 'Exercise 1' do
    let(:model) { Day01.new fixture_data }

    it 'finds pair that equals 2020' do
      expect(model.exercise1).to eq 802011
    end

    it 'finds trio that equals 2020' do
      expect(model.exercise2).to eq 248607374
    end

  end
end
