require 'spec_helper'

describe UKMail::DomesticServices, '.all_delivery_types' do
  subject { described_class.all_delivery_types }

  it 'returns list of unique delivery types' do
    expect(subject).to match_array([
      'Signature Service to the specified address & neighbour',
      'Signature Service to the specified address only',
      'Leave Safe at specified address or signature service to neighbour'
    ])
  end
end
