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
      'iyr:2011 ecl:brn hgt:59in',
    ]
  end
  let(:fixture) { File.join fixtures_path, 'day_04.data'}
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

  context 'with Birth Year Validator' do
    let(:field) { PassportField.new '', ''}
    let(:validator) { BirthYearValidator.new field }

    context 'when value is 2002' do
      before { field.value = '2002'}
      it 'is valid' do
        expect(validator.valid?).to be true
      end
    end
    context 'when value is 2003' do
      before { field.value = '2003' }
      it 'is invalid' do
        expect(validator.valid?).not_to be true
      end
    end
    context 'when value is 1919' do
      before { field.value = '1919' }
      it 'is invalid' do
        expect(validator.valid?).not_to be true
      end
    end
    context 'when value is 1920' do
      before { field.value = '1920' }
      it 'is valid' do
        expect(validator.valid?).to be true
      end
    end
    context 'when value is 123' do
      before { field.value = '123' }
      it 'is invalid' do
        expect(validator.valid?).not_to be true
      end
    end
    context 'when value is TEST' do
      before { field.value = 'TEST' }
      it 'is invalid' do
        expect(validator.valid?).not_to be true
      end
    end
  end

  context 'with Height Validator' do
    let(:field) { PassportField.new '', ''}
    let(:validator) { HeightValidator.new field }

    context 'when value is 60in' do
      before { field.value = '60in' }
      it 'is valid' do
        expect(validator.valid?).to be true
      end
    end
    context 'when value is 190cm' do
      before { field.value = '190cm' }
      it 'is valid' do
        expect(validator.valid?).to be true
      end
    end
    context 'when value is 190in' do
      before { field.value = '190in' }
      it 'is invalid' do
        expect(validator.valid?).not_to be true
      end
    end
    context 'when value is 190' do
      before { field.value = '190' }
      it 'is invalid' do
        expect(validator.valid?).not_to be true
      end
    end
    context 'when value is 58in' do
      before { field.value = '58in' }
      it 'is invalid' do
        expect(validator.valid?).not_to be true
      end
    end
    context 'when value is 59in' do
      before { field.value = '59in' }
      it 'is invalid' do
        expect(validator.valid?).to be true
      end
    end
    context 'when value is 77in' do
      before { field.value = '77in' }
      it 'is invalid' do
        expect(validator.valid?).not_to be true
      end
    end
    context 'when value is 76in' do
      before { field.value = '76in' }
      it 'is invalid' do
        expect(validator.valid?).to be true
      end
    end
    context 'when value is 149cmn' do
      before { field.value = '149cmn' }
      it 'is invalid' do
        expect(validator.valid?).not_to be true
      end
    end
    context 'when value is 150cm' do
      before { field.value = '150cm' }
      it 'is invalid' do
        expect(validator.valid?).to be true
      end
    end
    context 'when value is 194cm' do
      before { field.value = '194cm' }
      it 'is invalid' do
        expect(validator.valid?).not_to be true
      end
    end
    context 'when value is 193cm' do
      before { field.value = '193cm' }
      it 'is invalid' do
        expect(validator.valid?).to be true
      end
    end
    context 'when value is TESTcm' do
      before { field.value = 'TESTcm' }
      it 'is invalid' do
        expect(validator.valid?).not_to be true
      end
    end
    context 'when value is TESTin' do
      before { field.value = 'TESTin' }
      it 'is invalid' do
        expect(validator.valid?).not_to be true
      end
    end
  end

  context 'with Hair Color Validator' do
    let(:field) { PassportField.new '', ''}
    let(:validator) { HairColorValidator.new field }

    context 'when value is #123abc' do
      before { field.value = '#123abc' }
      it 'is valid' do
        expect(validator.valid?).to be true
      end
    end
    context 'when value is #123abz' do
      before { field.value = '#123abz' }
      it 'is invalid' do
        expect(validator.valid?).not_to be true
      end
    end
    context 'when value is 123abc' do
      before { field.value = '123abc' }
      it 'is invalid' do
        expect(validator.valid?).not_to be true
      end
    end
    context 'when value is #1234567' do
      before { field.value = '#1234567' }
      it 'is invalid' do
        expect(validator.valid?).not_to be true
      end
    end
    context 'when value is #abcdef' do
      before { field.value = '#abcdef' }
      it 'is valid' do
        expect(validator.valid?).to be true
      end
    end
    context 'when value is #abcdefg' do
      before { field.value = '#abcdefg' }
      it 'is invalid' do
        expect(validator.valid?).not_to be true
      end
    end
    context 'when value is #abcdeg' do
      before { field.value = '#abcdeg' }
      it 'is invalid' do
        expect(validator.valid?).not_to be true
      end
    end
    context 'when value is #TEST' do
      before { field.value = '#TEST' }
      it 'is invalid' do
        expect(validator.valid?).not_to be true
      end
    end
  end

  context 'with Eye Color Validator' do
    let(:field) { PassportField.new '', ''}
    let(:validator) { EyeColorValidator.new field }

    context 'when value is brn' do
      before { field.value = 'brn' }
      it 'is valid' do
        expect(validator.valid?).to be true
      end
    end
    context 'when value is wat' do
      before { field.value = 'wat' }
      it 'is invalid' do
        expect(validator.valid?).not_to be true
      end
    end
  end

  context 'with Passport ID Validator' do
    let(:field) { PassportField.new '', ''}
    let(:validator) { PassportIdValidator.new field }

    context 'when value is 000000001' do
      before { field.value = '000000001' }
      it 'is valid' do
        expect(validator.valid?).to be true
      end
    end
    context 'when value is 0123456789' do
      before { field.value = '0123456789' }
      it 'is invalid' do
        expect(validator.valid?).not_to be true
      end
    end
    context 'when value is 12345678' do
      before { field.value = '1234568' }
      it 'is invalid' do
        expect(validator.valid?).not_to be true
      end
    end
    context 'when value is 00000TEST' do
      before { field.value = '00000TEST' }
      it 'is invalid' do
        expect(validator.valid?).not_to be true
      end
    end
  end

  context 'with Password Field Validation' do
    it 'finds invalid passport 1' do
      data = ['eyr:1972 cid:100', 'hcl:#18171d ecl:amb hgt:170 pid:186cm iyr:2018 byr:1926']
      passport = Passport.new data, true
      expect(passport).not_to be_valid
    end

    it 'finds invalid passport 2' do
      data = ['iyr:2019', 'hcl:#602927 eyr:1967 hgt:170cm', 'ecl:grn pid:012533040 byr:1946']
      passport = Passport.new data, true
      expect(passport).not_to be_valid
    end

    it 'finds invalid passport 3' do
      data = ['hcl:dab227 iyr:2012', 'ecl:brn hgt:182cm pid:021572410 eyr:2020 byr:1992 cid:277']
      passport = Passport.new data, true
      expect(passport).not_to be_valid
    end

    it 'finds invalid passport 4' do
      data = ['hgt:59cm ecl:zzz', 'eyr:2038 hcl:74454a iyr:2023', 'pid:3556412378 byr:2007']
      passport = Passport.new data, true
      expect(passport).not_to be_valid
    end

    it 'finds valid passport 1' do
      data = ['pid:087499704 hgt:74in ecl:grn iyr:2012 eyr:2030 byr:1980', 'hcl:#623a2f']
      passport = Passport.new data, true
      expect(passport).to be_valid
    end

    it 'finds valid passport 2' do
      data = ['eyr:2029 ecl:blu cid:129 byr:1989','iyr:2014 pid:896056539 hcl:#a97842 hgt:165cm']
      passport = Passport.new data, true
      expect(passport).to be_valid
    end

    it 'finds valid passport 3' do
      data = ['hcl:#888785','hgt:164cm byr:2001 iyr:2015 cid:88','pid:545766238 ecl:hzl','eyr:2022']
      passport = Passport.new data, true
      expect(passport).to be_valid
    end

    it 'finds valid passport 4' do
      data = ['iyr:2010 hgt:158cm hcl:#b6652a ecl:blu byr:1944 eyr:2021 pid:093154719']
      passport = Passport.new data, true
      expect(passport).to be_valid
    end
  end
end
