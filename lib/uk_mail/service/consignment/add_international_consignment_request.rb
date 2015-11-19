module UKMail
  module Service
    class Consignment
      class AddInternationalConsignmentRequest < RequestBase
        def get_response
          soap_service.addInternationalConsignment(soap::AddInternationalConsignment.new(soap::AddInternationalConsignmentWebRequest.new(
            *@validated_parameters
          ))).addInternationalConsignmentResult
        end

        def build
          params[:address] ||= {}

          @validated_parameters = [
            *build_group(
              {  name: 'Auth token',                  value: service.session.auth_token                      },
              {  name: 'Username',                    value: params[:username]                               },
              {  name: 'Account number',              value: params[:account_number]                         }
            ),
            soap::AddressWebModel.new(
              *build_group(
                {  name: 'Address line 1',            value: params[:address][:address_1]                    },
                {  name: 'Address line 2',            value: params[:address][:address_2],      default: ''  },
                {  name: 'Address line 3',            value: params[:address][:address_3],      default: ''  },
                {  name: 'Address country code',      value: params[:address][:country_code]                 },
                {  name: 'Address county',            value: params[:address][:county],         default: ''  },
                {  name: 'Address postal town',       value: params[:address][:postal_town]                  },
                {  name: 'Address postcode',          value: params[:address][:postcode]                     }
              )
            ),
            *build_group(
              {  name: 'Alternative reference',       value: params[:alternative_ref],          default: ''  },
              {  name: 'Business name',               value: params[:business_name],            default: ''  },
              {  name: 'Collection job number',       value: params[:collection_job_number]                  },
              {  name: 'Confirmation of delivery',    value: params[:confirmation_of_delivery]               },
              {  name: 'Contact name',                value: params[:contact_name],             default: ''  },
              {  name: 'Customers\' reference',       value: params[:customers_ref],            default: ''  },
              {  name: 'Email',                       value: params[:email],                    default: ''  },
              {  name: 'Number of items',             value: params[:items]                                  },
              {  name: 'Service key',                 value: params[:service_key]                            },
              {  name: 'Special instructions line 1', value: params[:special_instructions_1],   default: ''  },
              {  name: 'Special instructions line 2', value: params[:special_instructions_2],   default: ''  },
              {  name: 'Telephone',                   value: params[:telephone],                default: ''  },
              {  name: 'Weight',                      value: params[:weight]                                 },
              {  name: 'Currency code',               value: params[:currency_code]                          },
              {  name: 'Documents only',              value: params[:documents_only]                         },
              {  name: 'Extended cover required',     value: params[:extended_cover_required]                },
              {  name: 'Goods description line 1',    value: params[:goods_description_1]                    },
              {  name: 'Goods description line 2',    value: params[:goods_description_2],      default: ''  },
              {  name: 'Goods description line 3',    value: params[:goods_description_3],      default: ''  },
              {  name: 'Height',                      value: params[:height],                   default: 0   },
              {  name: 'In free circulation EU',      value: params[:in_free_circulation_eu]                 },
              {  name: 'Invoice type',                value: params[:invoice_type]                           },
              {  name: 'Length',                      value: params[:length],                   default: 0   },
              {  name: 'No dangerous goods',          value: params[:no_dangerous_goods]                     },
              {  name: 'Value',                       value: params[:value]                                  },
              {  name: 'Width',                       value: params[:width],                    default: 0   }
            )
          ]
        end
      end
    end
  end
end
