require 'spec_helper'

describe UKMail::Service::RequestBase, '#build_group' do
  let(:service) { UKMail::Service::ServiceBase.new(nil) }
  let(:request) { UKMail::Service::RequestBase.new(service, nil) }

  subject { request.__send__(:build_group, *args) }

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

    it "adds the fields to validation errors" do
      subject
      expect(request.validation_errors[:missing]).to eq(['Second', 'Third'])
    end
  end
end
