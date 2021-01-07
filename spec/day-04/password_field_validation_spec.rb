require './lib/day_04'

RSpec.describe 'with Password Field Validation' do
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
    data = ['eyr:2029 ecl:blu cid:129 byr:1989', 'iyr:2014 pid:896056539 hcl:#a97842 hgt:165cm']
    passport = Passport.new data, true
    expect(passport).to be_valid
  end

  it 'finds valid passport 3' do
    data = ['hcl:#888785', 'hgt:164cm byr:2001 iyr:2015 cid:88', 'pid:545766238 ecl:hzl', 'eyr:2022']
    passport = Passport.new data, true
    expect(passport).to be_valid
  end

  it 'finds valid passport 4' do
    data = ['iyr:2010 hgt:158cm hcl:#b6652a ecl:blu byr:1944 eyr:2021 pid:093154719']
    passport = Passport.new data, true
    expect(passport).to be_valid
  end
end
