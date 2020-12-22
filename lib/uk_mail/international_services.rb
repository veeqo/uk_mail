module UKMail
  module InternationalServices
    def self.list(params)
      url = if UKMail.config.env == :production
        'https://services.dhlparcel.co.uk/v2/products/parcels/deliveryProducts'
      else
        'https://services.qa.dhlparcel.co.uk/v2/products/parcels/deliveryProducts'
      end

      # TODO: Look up the limits for dimensions fields and perform validations.
      # If we exceed the limits, UK Mail returns an empty array with no message.

      query = {
        countryCode: params[:country_code],
        weight: params[:weight],
        length: params[:length],
        width: params[:width],
        height: params[:height],
        recipientAddressType: params[:recipient_address_type],
        recipientPostcode: params[:recipient_postcode],
        doorstepOnly: params[:doorstep_only]
      }

      client = HTTPClient.new
      client.default_header['X-Api-Key'] = params.delete(:api_key).to_s
      response = client.get(url, query)

      if response.status == 200
        return JSON.parse(response.body).map do |response_service|
          InternationalService.new(
            response_service['ProductDescription'],
            response_service['ProductCode'],
            response_service['BusinessUnitCode'],
            response_service['CustomsDeclaration']
          )
        end
      end

      if response.status == 401
        raise UKMail::ServiceError, 'API key is invalid.'
      end

      if response.status == 400
        error_message = JSON.parse(response.body)['Errors'].values.join("\n")
        raise UKMail::ServiceError, error_message
      end

      raise UKMail::ServiceError, 'An unknown error occurred.'
    end

    class InternationalService
      attr_accessor :name
      attr_accessor :key
      attr_accessor :business_unit_code
      attr_accessor :customs_declaration

      def initialize(name, key, business_unit_code, customs_declaration)
        @name = name
        @key = key
        @business_unit_code = business_unit_code
        @customs_declaration = customs_declaration
      end
    end
  end
end
