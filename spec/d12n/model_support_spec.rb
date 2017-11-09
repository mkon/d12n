RSpec.describe 'D12n model support' do
  class Dummy
    include D12n::ModelSupport

    attr_accessor :amount
    d12n_attribute :amount
  end

  subject { Dummy.new }

  shared_examples 'Correct behavior' do
    it 'sets the values correctly' do
      subject.local_amount = input
      expect(subject.amount).to be_a BigDecimal
      expect(subject.amount.to_f).to eq(expected_value)
      expect(subject.local_amount).to eq(input)
    end
  end

  context 'when the default strategy is used' do
    context 'when using , and .' do
      let(:input) { '12,345.67' }
      let(:expected_value) { 12_345.67 }

      include_examples 'Correct behavior'
    end

    context 'when using .' do
      let(:input) { '12345.67' }
      let(:expected_value) { 12_345.67 }

      include_examples 'Correct behavior'
    end

    context 'when using ,' do
      let(:input) { '12,345' }
      let(:expected_value) { 12_345 }

      include_examples 'Correct behavior'
    end
  end

  context 'when the DecimalComma strategy is used' do
    before do
      allow(D12n).to receive(:strategy).and_return(D12n::Strategy::DecimalComma)
    end

    context 'when the default strategy is used' do
      context 'when using , and .' do
        let(:input) { '12.345,67' }
        let(:expected_value) { 12_345.67 }

        include_examples 'Correct behavior'
      end

      context 'when using ,' do
        let(:input) { '12345,67' }
        let(:expected_value) { 12_345.67 }

        include_examples 'Correct behavior'
      end

      context 'when using .' do
        let(:input) { '12.345' }
        let(:expected_value) { 12_345 }

        include_examples 'Correct behavior'
      end
    end
  end
end
