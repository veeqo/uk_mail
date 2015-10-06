require 'spec_helper'

describe UKMail::ShippingServices, '#list' do
  let(:postcode) { 'AB31 3DP' }
  let(:delivery_type) { '' }

  subject { UKMail::ShippingServices.list(parcel_type, delivery_type, postcode) }

  context "when the parcel type doesn't exist" do
    let(:parcel_type) { 'arglebargle' }

    it "raises an exception" do
      expect{subject}.to raise_error(RuntimeError)
    end
  end

  context "when the parcel type exists" do
    let(:parcel_type) { 'Bagit Medium' }

    context "when the delivery type doesn't exist" do
      let(:delivery_type) { 'foofaraw' }

      it "raises an exception" do
        expect{subject}.to raise_error(RuntimeError)
      end
    end

    context "when the delivery type exists" do
      let(:delivery_type) { 'Signature Service to the specified address & neighbour' }

      it "returns the correct set of available services" do
        expect(subject.length).to eq(4)

        expected_services = [
          UKMail::ShippingServices::ShippingService.new('Next Day', 30),
          UKMail::ShippingServices::ShippingService.new('Afternoon', 253),
          UKMail::ShippingServices::ShippingService.new('Evening', 254),
          UKMail::ShippingServices::ShippingService.new('48 Hour', 48)
        ]

        expected_services.each do |expected_service|
          exists = subject.any? do |returned_service|
            returned_service.name == expected_service.name &&
            returned_service.id == expected_service.id
          end
          expect(exists).to be_truthy
        end
      end
    end
  end
end
