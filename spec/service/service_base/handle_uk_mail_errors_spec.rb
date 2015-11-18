require 'spec_helper'

describe UKMail::Service::ServiceBase, '#handle_uk_mail_errors' do
  let(:service) { UKMail::Service::ServiceBase.new(nil) }
  let(:response) do
    UKMail::SoapService::Collection::UKMAddCollectionWebResponse.new(errors, nil,nil,nil,nil)
  end
  let(:errors) do
    [ UKMail::SoapService::Collection::UKMWebError.new('1234', 'Error one'),
      UKMail::SoapService::Collection::UKMWebError.new('5678', 'Error two') ]
  end

  subject { service.__send__(:handle_uk_mail_errors, response) }

  it 'raises an exception with all error codes and messages' do
    expect{subject}.to raise_error(UKMail::UKMailError, "1234: Error one\n5678: Error two")
  end
end
