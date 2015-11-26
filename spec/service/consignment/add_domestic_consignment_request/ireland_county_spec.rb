require 'spec_helper'

describe UKMail::Service::Consignment::AddDomesticConsignmentRequest, '#ireland_county' do
  let(:request) { UKMail::Service::Consignment::AddDomesticConsignmentRequest.new(nil, params) }
  let(:params) do
    {
      address: {
        county: county,
        postcode: nil
      }
    }
  end

  shared_examples_for 'correct conversion' do
    it 'returns the expected result' do
      expect(subject).to eq(expected_result)
    end

    it 'does not add any validation errors' do
      expect{subject}.not_to change{request.validation_errors}
    end
  end

  subject { request.ireland_county }

  context 'with a real county' do
    let(:county) { 'Wexford' }
    let(:expected_result) { 'Wexford' }

    it_should_behave_like 'correct conversion'
  end

  context 'with a real county but with incorrect case' do
    let(:county) { 'wexford' }
    let(:expected_result) { 'Wexford' }

    it_should_behave_like 'correct conversion'
  end

  context 'with a prefixed real county' do
    let(:county) { 'C. Wexford' }
    let(:expected_result) { 'Wexford' }

    it_should_behave_like 'correct conversion'
  end

  context 'with an invalid county' do
    let(:county) { 'C. Notrealcounty' }

    it 'returns the input county without its prefix' do
      expect(subject).to eq('Notrealcounty')
    end

    it 'adds a validation error' do
      expect{subject}.to change{request.validation_errors[:other]}.from(nil).to(
        ["'Notrealcounty' is not a valid Ireland county."]
      )
    end
  end
end
