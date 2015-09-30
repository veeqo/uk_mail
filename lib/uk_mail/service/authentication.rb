module UKMail
  module Service
    class AuthenticationService < Base
      def login(params = {})
        service.login(soap::Login.new(soap::LoginWebRequest.new(

          params[:password],
          params[:username]

        ))).loginResult
      end

      protected

      def soap
        SoapService::Authentication
      end

      def soap_service
        soap::IUKMAuthenticationService
      end
    end
  end
end
