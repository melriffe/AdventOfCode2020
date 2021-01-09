# frozen_string_literal: true
require './lib/day_18'

RSpec.describe MathProblem do

  subject { described_class.new test_expression }

  describe '#build' do
    let(:bet) { subject.build }

    context 'when expression is 3 + 4' do
      let(:test_expression) { '3 + 4' }

      it 'builds binary expression tree' do
        expect(bet.data).to be_addition
      end
    end

    context 'when expression is 3 * 4' do
      let(:test_expression) { '3 * 4' }

      it 'builds binary expression tree' do
        expect(bet.data).to be_multiplication
      end
    end

    context 'when expression is 1 + 2 * 3' do
      let(:test_expression) { '1 + 2 * 3' }

      it 'builds binary expression tree' do
        expect(bet.data).to be_multiplication
      end
    end

    context 'when expression is (1 + 2) * 3' do
      let(:test_expression) { '(1 + 2) * 3' }

      it 'builds binary expression tree' do
        expect(bet.data).to be_multiplication
      end
    end

    context 'when expression is 1 + (2 * 3)' do
      let(:test_expression) { '1 + (2 * 3)' }

      it 'builds binary expression tree' do
        expect(bet.data).to be_addition
      end
    end

    context 'when expression is ((2 * 2) + 3 * (5 + 6) + 1) + 9' do
      let(:test_expression) { '((2 * 2) + 3 * (5 + 6) + 1) + 9' }

      it 'builds binary expression tree' do
        expect(bet.data).to be_addition
      end
    end
  end

  describe '#solve' do
    context 'when expression is 3 + 4' do
      let(:test_expression) { '3 + 4' }

      it 'returns 7' do
        expect(subject.solve).to eq 7
      end
    end

    context 'when expression is 3 * 4' do
      let(:test_expression) { '3 * 4' }

      it 'returns 12' do
        expect(subject.solve).to eq 12
      end
    end

    context 'when expression is 1 + 2 * 3' do
      let(:test_expression) { '1 + 2 * 3' }

      it 'returns 9' do
        expect(subject.solve).to eq 9
      end
    end

    context 'when expression is (1 + 2) * 3' do
      let(:test_expression) { '(1 + 2) * 3' }

      it 'returns 9' do
        expect(subject.solve).to eq 9
      end
    end

    context 'when expression is 1 + (2 * 3)' do
      let(:test_expression) { '1 + (2 * 3)' }

      it 'returns 7' do
        expect(subject.solve).to eq 7
      end
    end

    context 'when expression is ((2 * 2) + 3 * (5 + 6) + 1) + 9' do
      let(:test_expression) { '((2 * 2) + 3 * (5 + 6) + 1) + 9' }

      it 'returns 87' do
        expect(subject.solve).to eq 87
      end
    end
  end
end
