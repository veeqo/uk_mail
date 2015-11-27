require 'spec_helper'

describe UKMail::IrelandData, '#ireland_county' do
  let(:ireland_data) { UKMail::IrelandData.new(county, postcode) }
  let(:postcode) { nil }

  subject { ireland_data.ireland_county }

  context 'with a real county' do
    let(:county) { 'Wexford' }

    it { is_expected.to eq('Wexford') }
  end

  context 'with a real county but with incorrect case' do
    let(:county) { 'wexford' }

    it { is_expected.to eq('Wexford') }
  end

  context 'with a prefixed real county' do
    let(:county) { 'C. Wexford' }

    it { is_expected.to eq('Wexford') }
  end

  context 'with an invalid county' do
    let(:county) { 'C. Notrealcounty' }

    it { is_expected.to be_nil }
  end
end
