require 'spec_helper'

describe UKMail::Service, '#parameters' do
  let(:service) { UKMail::Service::Base.new(nil) }

  subject { service.__send__(:parameters, *args) }

  context "when the args are all provided" do
    let(:args) { [
        { value: 1 },
        { value: "two" },
        { value: 3.0 }
    ] }
    let(:result) { [ 1, "two", 3.0 ] }

    it { is_expected.to eq(result) }
  end

  context "when there are default args" do
    let(:args) { [
        { value: 1 },
        { value: "two", default: "zero" },
        { value: nil, default: 5 },
        { value: "", default: "hi" }
    ] }
    let(:result) { [ 1, "two", 5, "hi" ] }

    it { is_expected.to eq(result) }
  end

  context "when required args are not provided" do
    let(:args) { [
        { name: 'First',  value: 1 },
        { name: 'Second', value: nil },
        { name: 'Third',  value: "" }
    ] }

    it "raises an exception" do
      message = "The following required fields are missing or empty: Second, Third"
      expect{subject}.to raise_error(UKMail::ValidationError, message)
    end
  end
end
