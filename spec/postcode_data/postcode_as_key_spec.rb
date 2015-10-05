require 'spec_helper'

describe UKMail::PostcodeData, '#postcode_as_key' do
  subject { UKMail::PostcodeData.postcode_as_key(postcode) }

  context "with lower case" do
    let(:postcode) { 'sa1 1dp' }
    it { is_expected.to eq 'SA1 1' }
  end

  context "with no spaces" do
    let(:postcode) { 'SA11DP' }
    it { is_expected.to eq 'SA1 1' }
  end

  context "with too many spaces" do
    let(:postcode) { ' SA  1 1D   P   ' }
    it { is_expected.to eq 'SA1 1' }
  end

  context "2 outer 0 inner" do
    let(:postcode) { 'S1' }
    it { is_expected.to eq 'S1   ' }
  end

  context "2 outer 3 inner" do
    let(:postcode) { 'S1 1DP' }
    it { is_expected.to eq 'S1  1' }
  end

  context "3 outer 3 inner" do
    let(:postcode) { 'SA1 1DP' }
    it { is_expected.to eq 'SA1 1' }
  end

  context "4 outer 0 inner" do
    let(:postcode) { 'SA10' }
    it { is_expected.to eq 'SA10 ' }
  end

  context "4 outer 3 inner" do
    let(:postcode) { 'SA12 1DP' }
    it { is_expected.to eq 'SA121' }
  end
end
