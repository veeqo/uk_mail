require 'spec_helper'
require 'shared_examples/soap_service/endpoint_url.rb'

describe UKMail::SoapService::Collection::IUKMCollectionService, '#endpoint_url' do
  let(:service) { UKMail::SoapService::Collection::IUKMCollectionService.new }

  include_examples "endpoint_url"
end
