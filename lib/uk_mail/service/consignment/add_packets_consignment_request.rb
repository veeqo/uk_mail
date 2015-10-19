module UKMail
  module Service
    class Consignment
      class AddPacketsConsignmentRequest < RequestBase
        def get_response
          soap_service.addPacketConsignment(soap::AddPacketConsignment.new(soap::AddPacketConsignmentWebRequest.new(
            *validated_parameters
          ))).addPacketConsignmentResult
        end

        def build
          params[:address] ||= {}

          @validated_parameters = [
            *build_group(
              {  name: 'Authentication token',    value: service.session.auth_token,                  },
              {  name: 'Username',                value: params[:username]                            },
              {  name: 'Account number',          value: params[:account_number]                      },
              {  name: 'Collection job number',   value: params[:collection_job_number]               },
              {  name: 'Contact name',            value: params[:contact_name],          default: ''  },
              {  name: 'Business name',           value: params[:business_name],         default: ''  }
            ),
            soap::PacketAddressWebModel.new(
              *build_group(
                {  name: 'Address line 1',        value: params[:address][:address_1]                 },
                {  name: 'Address line 2',        value: params[:address][:address_2],   default: ''  },
                {  name: 'Address line 3',        value: params[:address][:address_3],   default: ''  },
                {  name: 'Address county',        value: params[:address][:county],      default: ''  },
                {  name: 'Address postal town',   value: params[:address][:postal_town]               },
                {  name: 'Address postcode',      value: params[:address][:postcode]                  }
              )
            ),
            *build_group(
              {  name: 'Customers\' reference',   value: params[:customers_ref],         default: ''  },
              {  name: 'Alternative reference',   value: params[:alternative_ref],       default: ''  },
              {  name: 'Weight in grams',         value: params[:weight_in_grams]                     },
              {  name: 'Packet length',           value: params[:packet_length],         default: 0   },
              {  name: 'Packet width',            value: params[:packet_width],          default: 0   },
              {  name: 'Packet height',           value: params[:packet_height],         default: 0   },
              {  name: 'Delivery message line 1', value: params[:delivery_message_1],    default: ''  },
              {  name: 'Delivery message line 2', value: params[:delivery_message_2],    default: ''  }
            )
          ]
        end
      end
    end
  end
end
