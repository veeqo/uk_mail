# encoding: UTF-8
# Generated by wsdl2ruby (SOAP4R-NG/2.0.3)
require_relative 'UKMCollectionService.rb'
require_relative 'UKMCollectionServiceMappingRegistry.rb'
require 'soap/rpc/driver'

module UKMail::SoapService::Collection

class IUKMCollectionService < ::SOAP::RPC::Driver
  TEST_URL = 'https://qa-api.ukmail.com/Services/UKMCollectionServices/UKMCollectionService.svc'
  LIVE_URL = 'https://api.ukmail.com/Services/UKMCollectionServices/UKMCollectionService.svc'

  Methods = [
    [ "http://www.UKMail.com/Services/IUKMCollectionService/BookCollection",
      "bookCollection",
      [ [:in, "parameters", ["::SOAP::SOAPElement", "http://www.UKMail.com/Services/Contracts/ServiceContracts", "BookCollection"]],
        [:out, "parameters", ["::SOAP::SOAPElement", "http://www.UKMail.com/Services/Contracts/ServiceContracts", "BookCollectionResponse"]] ],
      { :request_style =>  :document, :request_use =>  :literal,
        :response_style => :document, :response_use => :literal,
        :faults => {} }
    ]
  ]

  def initialize(env: :test)
    endpoint_url = (env == :production ? LIVE_URL : TEST_URL)
    super(endpoint_url, nil)
    self.mapping_registry = UKMCollectionServiceMappingRegistry::EncodedRegistry
    self.literal_mapping_registry = UKMCollectionServiceMappingRegistry::LiteralRegistry
    init_methods
  end

private

  def init_methods
    Methods.each do |definitions|
      opt = definitions.last
      if opt[:request_style] == :document
        add_document_operation(*definitions)
      else
        add_rpc_operation(*definitions)
        qname = definitions[0]
        name = definitions[2]
        if qname.name != name and qname.name.capitalize == name.capitalize
          ::SOAP::Mapping.define_singleton_method(self, qname.name) do |*arg|
            __send__(name, *arg)
          end
        end
      end
    end
  end
end


end