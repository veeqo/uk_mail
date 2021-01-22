require 'spec_helper'
require 'shared_examples/soap_service/endpoint_url.rb'

describe UKMail::SoapService::Consignment::IUKMParcelShopConsignmentService, '#endpoint_url' do
  let(:service) { described_class.new }

  include_examples "endpoint_url"
end
