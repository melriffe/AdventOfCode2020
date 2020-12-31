require './lib/day_04'

RSpec.describe BirthYearValidator do

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
