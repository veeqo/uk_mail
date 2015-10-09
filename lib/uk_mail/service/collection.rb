module UKMail
  module Service
    class Collection < Base
      def book_collection(params = {})
        service.bookCollection(soap::BookCollection.new(soap::AddCollectionWebRequest.new(

          *parameters(
            {  value: @session.auth_token                 },
            {  value: params[:username]                   },
            {  value: params[:account_number]             },
            {  value: params[:closed_for_lunch]           },
            {  value: params[:earliest_time]              },
            {  value: params[:latest_time]                },
            {  value: params[:requested_collection_date]  },
            {  value: params[:special_instructions],      default: "" }
          )

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
