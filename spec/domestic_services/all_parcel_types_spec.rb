require 'spec_helper'

describe UKMail::DomesticServices, '.all_parcel_types' do
  subject { described_class.all_parcel_types }

  it 'returns list of unique parcel types' do
    expect(subject).to match_array([
      'Parcels',
      'Bagit Small',
      'Bagit Medium',
      'Bagit Large',
      'Bagit XL'
    ])
  end
end
