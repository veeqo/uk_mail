require 'spec_helper'

describe UKMail::Service::ServiceBase, '#handle_validation_errors' do
  let(:service) { UKMail::Service::ServiceBase.new(nil) }

  subject { service.__send__(:handle_validation_errors, validation_errors) }

  context "when there are no errors" do
    let(:validation_errors) { {} }

    it "doesn't raise an error" do
      expect{subject}.not_to raise_error
    end
  end

  context "when there are missing parameter errors" do
    let(:validation_errors) do
      { missing: ['Name', 'Address', 'Phone'] }
    end

    it "raises an error" do
      message = 'The following required fields are missing or empty: Name, Address, Phone'
      expect{subject}.to raise_error(UKMail::ValidationError, message)
    end
  end
end
