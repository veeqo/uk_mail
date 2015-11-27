require 'spec_helper'

describe UKMail::DomesticServices, '#list' do
  let(:postcode) { 'AB31 3DP' }
  let(:delivery_type) { '' }
  let(:country) { 'GB' }
  let(:county) { nil}

  subject { UKMail::DomesticServices.list(parcel_type, delivery_type, country, county, postcode) }

  context "when the parcel type doesn't exist" do
    let(:parcel_type) { 'arglebargle' }

    it "raises an exception" do
      expect{subject}.to raise_error(UKMail::ServiceError)
    end
  end

  context "when the parcel type exists" do
    let(:parcel_type) { 'Bagit Medium' }

    context "when the delivery type doesn't exist" do
      let(:delivery_type) { 'foofaraw' }

      it "raises an exception" do
        expect{subject}.to raise_error(UKMail::ServiceError)
      end
    end

    shared_examples_for 'expected result' do
      it "returns the correct set of available services" do
        expect(subject.length).to eq(expected_services.length)
        expected_services.each do |expected_service|
          exists = subject.any? do |returned_service|
            returned_service.name == expected_service.name &&
            returned_service.key == expected_service.key
          end
          expect(exists).to be_truthy
        end
      end
    end

    context "when the delivery type exists" do
      let(:delivery_type) { 'Signature Service to the specified address & neighbour' }

      context "when the country is not Ireland" do
        let(:country) { 'GBR' }
        let(:expected_services) { [
          UKMail::DomesticServices::DomesticService.new('Next Day', 30),
          UKMail::DomesticServices::DomesticService.new('Afternoon', 253),
          UKMail::DomesticServices::DomesticService.new('Evening', 254),
          UKMail::DomesticServices::DomesticService.new('48 Hour', 48)
        ] }

        it_behaves_like 'expected result'
      end

      context "when the country is Ireland" do
        let(:country) { 'IRL' }

        context "when the county is not valid" do
          let(:county) { 'notrealcounty' }

          it "raises an error" do
            expect{subject}.to raise_error(UKMail::ServiceError)
          end
        end

        context "when the county is valid" do
          let(:county) { 'waterford' }
          let(:expected_services) { [
            UKMail::DomesticServices::DomesticService.new('Afternoon', 253),
            UKMail::DomesticServices::DomesticService.new('Evening', 254),
            UKMail::DomesticServices::DomesticService.new('48 Hour', 48)
          ] }

          it_behaves_like 'expected result'
        end
      end
    end
  end
end
