module UKMail
  module Service
    class Collection
      class BookCollectionRequest < RequestBase
        def get_response
          soap_service.bookCollection(soap::BookCollection.new(soap::AddCollectionWebRequest.new(
            *validated_parameters
          ))).bookCollectionResult
        end

        def build
          validated_parameters = build_group(
            {  name: 'Auth token',                value: service.session.auth_token          },
            {  name: 'Username',                  value: params[:username]                   },
            {  name: 'Account number',            value: params[:account_number]             },
            {  name: 'Closed for lunch',          value: params[:closed_for_lunch]           },
            {  name: 'Earliest time',             value: params[:earliest_time]              },
            {  name: 'Latest time',               value: params[:latest_time]                },
            {  name: 'Requested collection date', value: params[:requested_collection_date]  },
            {  name: 'Special instructions',      value: params[:special_instructions],      default: '' }
          )
        end
      end
    end
  end
end
