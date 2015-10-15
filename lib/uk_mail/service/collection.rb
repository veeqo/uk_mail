module UKMail
  module Service
    class Collection < Base
      def book_collection(params = {})
        service.bookCollection(soap::BookCollection.new(soap::AddCollectionWebRequest.new(

          *parameters(
            {  name: 'Auth token',                value: @session.auth_token                 },
            {  name: 'Username',                  value: params[:username]                   },
            {  name: 'Account number',            value: params[:account_number]             },
            {  name: 'Closed for lunch',          value: params[:closed_for_lunch]           },
            {  name: 'Earliest time',             value: params[:earliest_time]              },
            {  name: 'Latest time',               value: params[:latest_time]                },
            {  name: 'Requested collection date', value: params[:requested_collection_date]  },
            {  name: 'Special instructions',      value: params[:special_instructions],      default: "" }
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
