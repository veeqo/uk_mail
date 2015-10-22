require 'spec_helper'

describe UKMail::PostcodeData, '#row_from_postcode' do
  subject { UKMail::PostcodeData.row_from_postcode(postcode) }

  context "when the postcode exists" do
    let(:postcode) { 'AB31 3DP' }

    it "returns the correct row" do
      expect(subject.postcode).to eq 'AB313'
    end
  end

  context "when the postcode doesn't exist" do
    let(:postcode) { 'XY987XY' }

    it "raises an exception" do
      expect{subject}.to raise_error(UKMail::ServiceError)
    end
  end
end
