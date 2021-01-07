require './lib/day_04'

RSpec.describe 'Day 4: Passport Processing' do
  let(:test_data) do
    [
      'ecl:gry pid:860033327 eyr:2020 hcl:#fffffd',
      'byr:1937 iyr:2017 cid:147 hgt:183cm',
      '',
      'iyr:2013 ecl:amb cid:350 eyr:2023 pid:028048884',
      'hcl:#cfa07d byr:1929',
      '',
      'hcl:#ae17e1 iyr:2013',
      'eyr:2024',
      'ecl:brn pid:760753108 byr:1931',
      'hgt:179cm',
      '',
      'hcl:#cfa07d eyr:2025 pid:166559648',
      'iyr:2011 ecl:brn hgt:59in'
    ]
  end
  let(:fixture) { File.join fixtures_path, 'day_04.data' }
  let(:fixture_data) { [] }

  before do
    File.readlines(fixture).each do |line|
      fixture_data << line.chomp
    end
  end

  context 'Examples' do
    let(:model) { Day04.new test_data }

    it 'finds valid passports' do
      expect(model.exercise1).to eq 2
    end
  end

  context 'Exercises' do
    let(:model) { Day04.new fixture_data }

    it 'finds valid passports' do
      expect(model.exercise1).to eq 256
    end

    it 'finds valid passports' do
      expect(model.exercise2).to eq 198
    end
  end
end
