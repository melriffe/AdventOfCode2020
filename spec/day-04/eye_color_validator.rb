require './lib/day_04'

RSpec.describe EyeColorValidator do
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
