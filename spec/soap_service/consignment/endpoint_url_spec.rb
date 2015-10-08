require 'spec_helper'
require 'shared_examples/soap_service/endpoint_url.rb'

describe UKMail::SoapService::Consignment::IUKMConsignmentService, '#endpoint_url' do
  let(:service) { UKMail::SoapService::Consignment::IUKMConsignmentService.new }

  include_examples "endpoint_url"
end
