module UKMail
  module Service
    class Collection < ServiceBase
      def book_collection(params = {})
        make_request(BookCollectionRequest, params)
      end

      def soap
        SoapService::Collection
      end

      def soap_service
        @soap_service ||= soap::IUKMCollectionService.new
      end
    end
  end
end
