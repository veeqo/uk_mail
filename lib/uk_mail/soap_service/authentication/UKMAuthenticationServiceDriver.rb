# encoding: UTF-8
# Generated by wsdl2ruby (SOAP4R-NG/2.0.3)
require_relative 'UKMAuthenticationService.rb'
require_relative 'UKMAuthenticationServiceMappingRegistry.rb'
require 'soap/rpc/driver'

module UKMail::SoapService::Authentication

class IUKMAuthenticationService < ::SOAP::RPC::Driver
  TEST_URL = 'https://qa-api.ukmail.com/Services/UKMAuthenticationServices/UKMAuthenticationService.svc'
  LIVE_URL = 'https://api.ukmail.com/Services/UKMAuthenticationServices/UKMAuthenticationService.svc'

  Methods = [
    [ "http://www.UKMail.com/Services/IUKMAuthenticationService/Login",
      "login",
      [ [:in, "parameters", ["::SOAP::SOAPElement", "http://www.UKMail.com/Services/Contracts/ServiceContracts", "Login"]],
        [:out, "parameters", ["::SOAP::SOAPElement", "http://www.UKMail.com/Services/Contracts/ServiceContracts", "LoginResponse"]] ],
      { :request_style =>  :document, :request_use =>  :literal,
        :response_style => :document, :response_use => :literal,
        :faults => {} }
    ],
    [ "http://www.UKMail.com/Services/IUKMAuthenticationService/Logout",
      "logout",
      [ [:in, "parameters", ["::SOAP::SOAPElement", "http://www.UKMail.com/Services/Contracts/ServiceContracts", "Logout"]],
        [:out, "parameters", ["::SOAP::SOAPElement", "http://www.UKMail.com/Services/Contracts/ServiceContracts", "LogoutResponse"]] ],
      { :request_style =>  :document, :request_use =>  :literal,
        :response_style => :document, :response_use => :literal,
        :faults => {} }
    ]
  ]

  def initialize
    endpoint_url = (UKMail.config.env == :production ? LIVE_URL : TEST_URL)
    super(endpoint_url, nil)
    self.mapping_registry = UKMAuthenticationServiceMappingRegistry::EncodedRegistry
    self.literal_mapping_registry = UKMAuthenticationServiceMappingRegistry::LiteralRegistry
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
