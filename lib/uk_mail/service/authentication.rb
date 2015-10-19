module UKMail
  module Service
    class Authentication < ServiceBase
      def login(params = {})
        soap_service.login(soap::Login.new(soap::LoginWebRequest.new(

          params[:password],
          params[:username]

        ))).loginResult
      end

      def soap
        SoapService::Authentication
      end

      def soap_service
        @soap_service ||= soap::IUKMAuthenticationService.new
      end
    end
  end
end
