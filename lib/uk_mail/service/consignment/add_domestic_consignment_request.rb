module UKMail
  module Service
    class Consignment
      class AddDomesticConsignmentRequest < RequestBase
        def get_response
          soap_service.addDomesticConsignment(soap::AddDomesticConsignment.new(soap::AddDomesticConsignmentWebRequest.new(
            *validated_parameters
          ))).addDomesticConsignmentResult
        end

        def build
          params[:address] ||= {}

          @validated_parameters = [
            *build_group(
              {  name: 'Auth token',                  value: service.session.auth_token                       },
              {  name: 'Username',                    value: params[:username]                                },
              {  name: 'Account number',              value: params[:account_number]                          }
            ),
            soap::AddressWebModel.new(
              *build_group(
                {  name: 'Address line 1',            value: params[:address][:address_1]                     },
                {  name: 'Address line 2',            value: params[:address][:address_2],       default: ''  },
                {  name: 'Address line 3',            value: params[:address][:address_3],       default: ''  },
                {  name: 'Address country code',      value: params[:address][:country_code]                  },
                {  name: 'Address county',            value: params[:address][:county],          default: ''  },
                {  name: 'Address postal town',       value: params[:address][:postal_town]                   },
                {  name: 'Address postcode',          value: params[:address][:postcode]                      }
              )
            ),
            *build_group(
              {  name: 'Alternative reference',       value: params[:alternative_ref],           default: ''  },
              {  name: 'Business name',               value: params[:business_name],             default: ''  },
              {  name: 'Collection job number',       value: params[:collection_job_number]                   },
              {  name: 'Confirmation of delivery',    value: params[:confirmation_of_delivery]                },
              {  name: 'Contact name',                value: params[:contact_name],              default: ''  },
              {  name: 'Customers\' reference',       value: params[:customers_ref],             default: ''  },
              {  name: 'Email',                       value: params[:email],                     default: ''  },
              {  name: 'Number of items',             value: params[:items]                                   },
              {  name: 'Service key',                 value: params[:service_key]                             },
              {  name: 'Special instructions line 1', value: params[:special_instructions_1],    default: ''  },
              {  name: 'Special instructions line 2', value: params[:special_instructions_2],    default: ''  },
              {  name: 'Telephone',                   value: params[:telephone],                 default: ''  },
              {  name: 'Weight',                      value: params[:weight]                                  },
              {  name: 'Book in',                     value: params[:book_in]                                 },
              {  name: 'COD amount',                  value: params[:cod_amount],                default: '0.00' },
              {  name: 'Confirmation email',          value: params[:confirmation_email],        defalut: ''  },
              {  name: 'Confirmation telephone',      value: params[:confirmation_telephone],    defalut: ''  },
              {  name: 'Exchange on delivery',        value: params[:exchange_on_delivery]                    },
              {  name: 'Extended cover',              value: params[:extended_cover]                          },
              {  name: 'Long length',                 value: params[:long_length]                             },
              {  name: 'Pre-delivery notification',   value: params[:pre_delivery_notification]               },
              {  name: 'Secure location line 1',      value: params[:secure_location_1],         default: ''  },
              {  name: 'Secure location line 2',      value: params[:secure_location_2],         default: ''  },
              {  name: 'Signature optional',          value: params[:signature_optional]                      }
            )
          ]
        end
      end
    end
  end
end
