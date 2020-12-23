require './lib/day_07'

RSpec.describe 'Day 7: Handy Haversacks' do
  let(:test_data) do
    [
      'light red bags contain 1 bright white bag, 2 muted yellow bags.',
      'dark orange bags contain 3 bright white bags, 4 muted yellow bags.',
      'bright white bags contain 1 shiny gold bag.',
      'muted yellow bags contain 2 shiny gold bags, 9 faded blue bags.',
      'shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.',
      'dark olive bags contain 3 faded blue bags, 4 dotted black bags.',
      'vibrant plum bags contain 5 faded blue bags, 6 dotted black bags.',
      'faded blue bags contain no other bags.',
      'dotted black bags contain no other bags.'
    ]
  end
  let(:fixture) { File.join fixtures_path, 'day_07.data'}
  let(:fixture_data) { [] }

  before do
    File.readlines(fixture).each do |line|
      fixture_data << line.chomp
    end
  end

  context 'Examples' do
    let(:model) { Day07.new test_data }

    it 'finds number of bags that contain at least one shiny gold bag' do
      expect(model.exercise1).to eq 4
    end

    it 'finds number of bags inside one shiny gold bag' do
      expect(model.exercise2).to eq 32
    end
  end

  context 'Exercises' do
    let(:model) { Day07.new fixture_data }

    it 'finds number of bags that contain at least one shiny gold bag' do
      expect(model.exercise1).to eq 177
    end

    it 'finds number of bags inside one shiny gold bag' do
      expect(model.exercise2).to eq 34988
    end
  end
end
