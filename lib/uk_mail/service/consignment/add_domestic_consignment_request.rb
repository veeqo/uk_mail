module UKMail
  module Service
    class Consignment
      class AddDomesticConsignmentRequest < RequestBase
        IRELAND_COUNTY_PREFIXES = %w[County Cnty CC. CC Ct. Ct Co. Co C.]
        IRELAND_COUNTIES = %w[
          Carlow Cavan Clare Cork Donegal Dublin Galway Kerry Kildare Kilkenny Laois Leitrim
          Limerick Longford Louth Mayo Meath Monaghan Offaly Roscommon Sligo Tipperary Waterford
          Westmeath Wexford Wicklow
        ]

        def get_response
          soap_service.addDomesticConsignmentV2(soap::AddDomesticConsignmentV2.new(soap::AddParcelShopDomesticConsignmentWebRequestV2.new(
            *@validated_parameters
          ))).addDomesticConsignmentV2Result
        end

        def build
          params[:address] ||= {}

          @validated_parameters = [
            *build_group(
              { name: 'Auth token',                  value: service.session.auth_token                       },
              { name: 'Username',                    value: params[:username]                                },
              { name: 'Account number',              value: params[:account_number]                          }
            ),
            soap::AddressWebModel.new(
              *build_group(
                { name: 'Address line 1',            value: params[:address][:address_1]                     },
                { name: 'Address line 2',            value: params[:address][:address_2],       default: ''  },
                { name: 'Address line 3',            value: params[:address][:address_3],       default: ''  },
                { name: 'Address country code',      value: params[:address][:country_code]                  },
                { name: 'Address county',            value: build_county,                       default: ''  },
                { name: 'Address postal town',       value: params[:address][:postal_town]                   },
                { name: 'Address postcode',          value: build_postcode                                   }
              )
            ),
            *build_group(
              { name: 'Alternative reference',       value: params[:alternative_ref],           default: ''  },
              { name: 'Business name',               value: params[:business_name],             default: ''  },
              { name: 'Collection job number',       value: params[:collection_job_number]                   },
              { name: 'Confirmation of delivery',    value: params[:confirmation_of_delivery]                },
              { name: 'Contact name',                value: params[:contact_name],              default: ''  },
              { name: 'Customers\' reference',       value: params[:customers_ref],             default: ''  },
              { name: 'Email',                       value: params[:email],                     default: ''  },
              { name: 'Height',                      value: params[:height],                    default: nil },
              { name: 'Number of items',             value: params[:items],                                  },
              { name: 'Length',                      value: params[:length],                    default: nil },
              { name: 'Provider Code',               value: params[:provider_code],             default: ''  },
              { name: 'Service key',                 value: params[:service_key]                             },
              { name: 'Service Point Code',          value: params[:service_point_code],        default: ''  },
              { name: 'Special instructions line 1', value: params[:special_instructions_1],    default: ''  },
              { name: 'Special instructions line 2', value: params[:special_instructions_2],    default: ''  },
              { name: 'Telephone',                   value: params[:telephone],                 default: ''  },
              { name: 'Weight',                      value: params[:weight]                                  },
              { name: 'Width',                       value: params[:width],                     default: nil },
              { name: 'Book in',                     value: params[:book_in]                                 },
              { name: 'COD amount',                  value: params[:cod_amount],                default: '0.00' },
              { name: 'Confirmation email',          value: params[:confirmation_email],        default: ''  },
              { name: 'Confirmation telephone',      value: params[:confirmation_telephone],    default: ''  },
              { name: 'Exchange on delivery',        value: params[:exchange_on_delivery]                    },
              { name: 'Extended cover',              value: params[:extended_cover]                          },
              { name: 'Long length',                 value: params[:long_length]                             },
              { name: 'Pre-delivery notification',   value: params[:pre_delivery_notification]               },
              { name: 'Secure location line 1',      value: params[:secure_location_1],         default: ''  },
              { name: 'Secure location line 2',      value: params[:secure_location_2],         default: ''  },
              { name: 'Signature optional',          value: signature_optional?                              },
            ),
            params[:basic_customs].nil? ? nil : soap::BasicCustomsDeclaration.new(
              *build_group(
                { name: 'Currency Code',           value: params[:basic_customs][:currency_code]             },
                { name: 'Description of Goods',    value: params[:basic_customs][:description_of_goods]      },
                { name: 'Documents Only',          value: params[:basic_customs][:documents_only]            },
                { name: 'Invoice Type',            value: params[:basic_customs][:invoice_type]              },
                { name: 'Value',                   value: params[:basic_customs][:value]                     }
              )
            ),
            params[:full_customs].nil? ? nil : soap::CustomsDeclaration.new(
              *build_group(
                { name: 'Articles',                value: full_customs_articles                              },
                { name: 'Currency Code',           value: params[:full_customs][:currency_code]              },
                { name: 'Invoice Date',            value: params[:full_customs][:invoice_date]               },
                { name: 'Invoice Number',          value: params[:full_customs][:invoice_number]             },
                { name: 'Invoice Type',            value: params[:full_customs][:invoice_type]               },
                { name: 'Reason for Export',       value: params[:full_customs][:reason_for_export]          },
                { name: 'Shipping Charges',        value: params[:full_customs][:shipping_charges]           },
                { name: 'Terms of Delivery',       value: params[:full_customs][:terms_of_delivery]          },
                { name: 'Total Articles',          value: params[:full_customs][:total_articles]             },
                { name: 'Total Value',             value: params[:full_customs][:total_value]                }
              )
            )
          ]
        end

        def full_customs_articles
          soap::Articles.new(
            soap::ArrayOfArticleDetail.new(
              params[:full_customs][:articles].map do |article_param|
                soap::ArticleDetail.new(
                  article_param[:commodity_code],
                  article_param[:country_of_manufacture],
                  article_param[:goods_description],
                  article_param[:quantity],
                  article_param[:unit_value],
                  article_param[:unit_weight]
                )
              end
            )
          )
        end

        def build_county
          ireland? ? ireland_county : params_county
        end

        def build_postcode
          ireland? ? ireland_postcode : params_postcode
        end

        def ireland_county
          ireland_data.ireland_county.tap do |county|
            add_validation_error(:other, "'#{county}' is not a valid Ireland county.") if county.nil?
          end
        end

        def ireland_postcode
          ireland_data.ireland_postcode.tap do |postcode|
            add_validation_error(:other, "#{params_postcode} is not a valid Dublin postcode.") if postcode.nil?
          end
        end

        def ireland_data
          @ireland_data ||= IrelandData.new(params_county, params_postcode)
        end

        def ireland?
          params[:address][:country_code] == 'IRL'
        end

        def params_county
          params[:address][:county].to_s
        end

        def params_postcode
          params[:address][:postcode].to_s
        end

        def signature_optional?
          signature_optional_by_key = DomesticServices.signature_optional_for_service_key(params[:service_key])

          if signature_optional_by_key.nil?
            params[:signature_optional]
          else
            signature_optional_by_key
          end
        end
      end
    end
  end
end
