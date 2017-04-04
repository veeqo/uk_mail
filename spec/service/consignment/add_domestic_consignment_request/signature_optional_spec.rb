require 'spec_helper'

describe UKMail::Service::Consignment::AddDomesticConsignmentRequest, '#signature_optional?' do
  subject { request.signature_optional? }

  let(:request) { described_class.new(nil, params) }
  let(:params) { { service_key: service_key, signature_optional: signature_optional } }
  let(:signature_optional) { nil }

  context 'with no service key' do
    let(:service_key) { nil }

    it 'raises an exception' do
      expect{subject}.to raise_error('Service key is required.')
    end
  end

  context 'with an address & neighbor service key' do
    let(:service_key) { 1 }

    it { is_expected.to eq(false) }
  end

  context 'with an address only service key' do
    let(:service_key) { 220 }

    it { is_expected.to eq(false) }
  end

  context 'with a leave safe service key' do
    let(:service_key) { 210 }

    context 'with true signature_optional' do
      let(:signature_optional) { true }

      it { is_expected.to eq(true) }
    end

    context 'with false signature_optional' do
      let(:signature_optional) { false }

      it { is_expected.to eq(false) }
    end
  end
end
