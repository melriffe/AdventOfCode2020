# frozen_string_literal: true
require './lib/day_04'

RSpec.describe HeightValidator do
  let(:field) { PassportField.new '', '' }
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
