module UKMail
  module Service
    class Consignment < ServiceBase
      def add_domestic_consignment(params = {})
        make_consignment_request(AddDomesticConsignmentRequest, params)
      end

      def add_domestic_consignment_v2(params = {})
        make_consignment_request(AddDomesticConsignmentV2Request, params)
      end

      def add_international_consignment(params = {})
        make_consignment_request(AddInternationalConsignmentRequest, params)
      end

      def add_packets_consignment(params = {})
        make_consignment_request(AddPacketsConsignmentRequest, params)
      end

      def soap
        SoapService::Consignment
      end

      def soap_service
        @soap_service ||= soap::IUKMConsignmentService.new
      end

      private

      def make_consignment_request(request_class, params)
        response = make_request(request_class, params)
        ConsignmentResponse.new(response.consignmentNumber, response.labels, nil)
      end
    end
  end
end
