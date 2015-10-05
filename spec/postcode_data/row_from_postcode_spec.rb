require 'spec_helper'

describe UKMail::PostcodeData, '#row_from_postcode' do
  subject { UKMail::PostcodeData.row_from_postcode(postcode) }

  context "when the postcode exists" do
    let(:postcode) { 'SA1 1DP' }

    it 'should return the correct row' do
      expect(subject.postcode).to eq 'SA1 1'
    end
  end

  context "when the postcode doesn't exist" do
    let(:postcode) { 'XY987XY' }

    it "should raise an exception" do
      expect{subject}.to raise_error(RuntimeError)
    end
  end
end
