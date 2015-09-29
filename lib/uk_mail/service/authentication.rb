require 'uk_mail/service/base'
require 'uk_mail/soap_service/authentication'

module UKMail
  module Service
    class AuthenticationService < Base
      def soap_namespace
        SoapService::Authentication
      end

      def soap_service
        soap_namespace::IUKMAuthenticationService
      end

      def login(params = {})
        service.login(soap_namespace::Login.new(soap_namespace::LoginWebRequest.new(

          params[:password],
          params[:username]

        ))).loginResult
      end
    end
  end
end
