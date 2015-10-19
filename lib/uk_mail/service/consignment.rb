module UKMail
  module Service
    class Consignment < ServiceBase
      def add_domestic_consignment(params = {})
        make_request(AddDomesticConsignmentRequest, params)
      end

      def add_international_consignment(params = {})
        make_request(AddInternationalConsignmentRequest, params)
      end

      def add_packets_consignment(params = {})
        make_request(AddPacketsConsignmentRequest, params)
      end

      def soap
        SoapService::Consignment
      end

      def soap_service
        @soap_service ||= soap::IUKMConsignmentService.new
      end
    end
  end
end
