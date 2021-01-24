# frozen_string_literal: true

require './lib/day_21'

RSpec.describe 'Day 21: Allergen Assessment' do
  let(:test_data) do
    [
      'mxmxvkd kfcds sqjhc nhms (contains dairy, fish)',
      'trh fvjkl sbzzf mxmxvkd (contains dairy)',
      'sqjhc fvjkl (contains soy)',
      'sqjhc mxmxvkd sbzzf (contains fish)'
    ]
  end
  let(:fixture) { File.join fixtures_path, 'day_21.data' }
  let(:fixture_data) { [] }

  before do
    File.readlines(fixture).each do |line|
      fixture_data << line.chomp
    end
  end

  context 'Examples' do
    let(:model) { Day21.new test_data }

    it 'finds number of non-allergen ingredients' do
      expect(model.exercise1).to eq 5
    end

    it 'finds the canonical dangerous ingredient list' do
      expect(model.exercise2).to eq 'mxmxvkd,sqjhc,fvjkl'
    end
  end

  context 'Exercises' do
    let(:model) { Day21.new fixture_data }

    it 'finds number of non-allergen ingredients' do
      expect(model.exercise1).to eq 2265
    end

    it 'finds the canonical dangerous ingredient list' do
      expect(model.exercise2).to eq 'dtb,zgk,pxr,cqnl,xkclg,xtzh,jpnv,lsvlx'
    end
  end
end
