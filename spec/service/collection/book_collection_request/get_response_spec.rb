require 'spec_helper'

describe UKMail::Service::Collection::BookCollectionRequest, '#get_response' do
  let(:session) { UKMail::Session.new(auth_token) }
  let(:service) { UKMail::Service::Collection.new(session) }
  let(:auth_token) { "DD43A924-62C0-49E9-84E5-F4106E2E02B1" }
  let(:params) do
    {
      username: username,
      account_number: account_number,
      closed_for_lunch: closed_for_lunch,
      earliest_time: earliest_time,
      latest_time: latest_time,
      requested_collection_date: requested_collection_date
    }
  end

  let(:username) { 'luke@veeqo.com' }
  let(:account_number) { 'E080389' }
  let(:closed_for_lunch) { false }
  let(:earliest_time) { Time.new(2015,11,19,9,0) }
  let(:latest_time) { Time.new(2015,11,19,11,30) }
  let(:requested_collection_date) { Time.new(2015,11,19,10,0) }

  subject { service.book_collection(params) }

  context 'with valid params', vcr: { cassette_name: '/service/collection/book_collection_request/get_response/with_valid_params' } do
    it 'does not raise an error' do
      expect{subject}.not_to raise_error
    end

    it 'returns a collection reference' do
      expect(subject.collectionJobNumber).to eq('GL47423760')
    end
  end
end
