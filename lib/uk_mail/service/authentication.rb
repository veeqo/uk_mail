require 'uk_mail/service/base'
require 'uk_mail/soap_service/authentication'

module UKMail
  module Service
    class AuthenticationService < Base
      def soap
        SoapService::Authentication
      end

      def soap_service
        soap::IUKMAuthenticationService
      end

      def login(params = {})
        service.login(soap::Login.new(soap::LoginWebRequest.new(

          params[:password],
          params[:username]

        ))).loginResult
      end
    end
  end
end
