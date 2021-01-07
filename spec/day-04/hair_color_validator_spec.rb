# frozen_string_literal: true
require './lib/day_04'

RSpec.describe HairColorValidator do
  let(:field) { PassportField.new '', '' }
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
