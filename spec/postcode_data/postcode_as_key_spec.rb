require 'spec_helper'

describe UKMail::PostcodeData, '#postcode_as_key' do
  subject { described_class.postcode_as_key(postcode) }

  shared_examples_for 'correct result' do |with_sector, without_sector|
    context 'with sector' do
      subject { described_class.postcode_as_key(postcode) }

      it { is_expected.to eq(with_sector) }
    end

    context 'without sector' do
      subject { described_class.postcode_as_key(postcode, with_sector: false) }

      it { is_expected.to eq(without_sector) }
    end
  end

  context "with lower case" do
    let(:postcode) { 'sa1 1dp' }
    include_examples 'correct result', 'SA1 1', 'SA1  '
  end

  context "with no spaces" do
    let(:postcode) { 'SA11DP' }
    include_examples 'correct result', 'SA1 1', 'SA1  '
  end

  context "with too many spaces" do
    let(:postcode) { ' SA  1 1D   P   ' }
    include_examples 'correct result', 'SA1 1', 'SA1  '
  end

  context "2 outer 0 inner" do
    let(:postcode) { 'S1' }
    include_examples 'correct result', 'S1   ', 'S1   '
  end

  context "2 outer 3 inner" do
    let(:postcode) { 'S1 1DP' }
    include_examples 'correct result', 'S1  1', 'S1   '
  end

  context "3 outer 3 inner" do
    let(:postcode) { 'SA1 1DP' }
    include_examples 'correct result', 'SA1 1', 'SA1  '
  end

  context "4 outer 0 inner" do
    let(:postcode) { 'SA10' }
    include_examples 'correct result', 'SA10 ', 'SA10 '
  end

  context "4 outer 3 inner" do
    let(:postcode) { 'SA12 1DP' }
    include_examples 'correct result', 'SA121', 'SA12 '
  end
end
