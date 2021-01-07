require './lib/day_04'

RSpec.describe PassportIdValidator do
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
