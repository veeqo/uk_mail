require 'spec_helper'

describe UKMail::DomesticServices, '#signature_optional_for_service_key' do
  subject { described_class.signature_optional_for_service_key(service_key) }

  context 'with nil' do
    let(:service_key) { nil }

    it 'raises an exception' do
      expect{subject}.to raise_error('Service key is required.')
    end
  end

  context 'with an unrecognised service key' do
    let(:service_key) { 9999 }

    it 'raises an exception' do
      expect{subject}.to raise_error('Service key \'9999\' is not supported.')
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

    it { is_expected.to eq(nil) }
  end
end
