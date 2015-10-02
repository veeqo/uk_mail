module UKMail
  module Service
    class Collection < Base
      def book_collection(params = {})
        service.bookCollection(soap::BookCollection.new(soap::AddCollectionWebRequest.new(

          @session.auth_token,
          params[:username],
          params[:account_number],
          params[:closed_for_lunch],
          params[:earliest_time],
          params[:latest_time],
          params[:requested_collection_date],
          params[:special_instructions]

        ))).bookCollectionResult
      end

      protected

      def soap
        SoapService::Collection
      end

      def soap_service
        soap::IUKMCollectionService
      end
    end
  end
end
