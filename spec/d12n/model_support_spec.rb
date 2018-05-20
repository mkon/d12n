RSpec.describe D12n::ModelSupport do
  class Dummy
    include D12n::ModelSupport

    attr_accessor :amount, :cents
    d12n_attribute :amount
    d12n_attribute :cents, factor: 100
  end

  subject(:model) { Dummy.new }

  shared_examples 'Correct behavior' do
    it 'parses the local format correctly' do
      subject.local_amount = input
      expect(subject.amount).to be_a BigDecimal
      expect(subject.amount.to_f).to eq(expected_value)
      expect(subject.local_amount).to eq(input)
    end

    it 'parses the local format correctly with a factor' do
      subject.local_cents = input
      expect(subject.cents).to be_a Integer
      expect(subject.cents).to eq(expected_value * 100)
      expect(subject.local_cents).to eq(input)
    end
  end

  shared_examples 'when using invalid format' do
    let(:input) { 'not-a-number' }

    it 'does not set internal amount' do
      subject.local_amount = input
      expect(subject.amount).to be nil
      expect(subject.local_amount).to eq(input)
    end
  end

  shared_examples 'correct behavior for decimal point' do
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

    it_behaves_like 'when using invalid format'
  end

  shared_examples 'correct behavior for decimal comma' do
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

    it_behaves_like 'when using invalid format'
  end

  describe 'local reader' do
    subject { model.local_amount }

    context 'when amount is 4567.89' do
      before { model.amount = 4_567.89 }

      it { is_expected.to eq '4,567.89' }
    end

    context 'when amount is nil' do
      it { is_expected.to eq nil }
    end
  end

  describe 'local reader with factor' do
    subject { model.local_cents }

    context 'when amount is 456_789' do
      before { model.cents = 456_789 }

      it { is_expected.to eq '4,567.89' }
    end

    context 'when amount is nil' do
      it { is_expected.to eq nil }
    end
  end

  it 'generates local amount from amount with a factor' do
    subject.cents = 456_789
    expect(subject.local_cents).to eq('4,567.89')
  end

  context 'when the Default strategy is used' do
    context 'when I18n format is decimal point' do
      before do
        I18n.backend = I18n::Backend::SimpleMock.new(delimiter: ',', separator: '.')
      end

      include_examples 'correct behavior for decimal point'
    end

    context 'when I18n format is decimal comma' do
      before do
        I18n.backend = I18n::Backend::SimpleMock.new(delimiter: '.', separator: ',')
      end

      include_examples 'correct behavior for decimal comma'
    end
  end

  context 'when the DecimalPoint strategy is used' do
    before do
      allow(D12n).to receive(:strategy).and_return(D12n::Strategy::DecimalPoint)
    end

    include_examples 'correct behavior for decimal point'
  end

  context 'when the DecimalComma strategy is used' do
    before do
      allow(D12n).to receive(:strategy).and_return(D12n::Strategy::DecimalComma)
    end

    include_examples 'correct behavior for decimal comma'
  end
end
