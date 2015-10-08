require 'spec_helper'
require 'shared_examples/soap_service/endpoint_url.rb'

describe UKMail::SoapService::Authentication::IUKMAuthenticationService, '#endpoint_url' do
  let(:service) { UKMail::SoapService::Authentication::IUKMAuthenticationService.new }

  include_examples "endpoint_url"
end
