require './lib/day_16'

RSpec.describe Rule do
  subject { described_class.new specification}

  let(:specification) { 'arrival platform: 49-746 or 772-955' }

  describe '#value_valid?' do
    context 'within first range' do
      it 'returns true' do
        expect(subject.value_valid? 49).to be true
      end
    end

    context 'within second range' do
      it 'returns true' do
        expect(subject.value_valid? 955).to be true
      end
    end

    context 'when not in any range' do
      it 'returns false' do
        expect(subject.value_valid? 760).not_to be true
      end
    end
  end
end
