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
        { value: nil, default: 5 }
    ] }
    let(:result) { [ 1, "two", 5 ] }

    it { is_expected.to eq(result) }
  end

  context "when required args are not provided" do # TODO: Failing
    let(:args) { [
        { value: 1 },
        { value: nil },
        { value: "" }
    ] }

    it "should raise an exception" do
      expect{subject}.to raise_error(RuntimeError)
    end
  end
end
