module UKMail
  module InternationalConsignment
    def self.perform(params)
      url = if UKMail.config.env == :production
        'https://services.dhlparcel.co.uk/v3/internationalconsignment/internationalconsignment'
      else
        'https://services.qa.dhlparcel.co.uk/v3/internationalconsignment/internationalconsignment'
      end

      client = HTTPClient.new
      client.default_header['X-Api-Key'] = UKMail.config.api_key
      client.default_header['Content-Type'] = 'application/json; charset=utf-8'
      response = client.post(url, params.to_json)

      if response.status == 401
        if response.reason.end_with? 'Authorization Required: Unauthorized'
          raise UKMail::AuthTokenError
        elsif response.reason == 'Unauthorized'
          raise UKMail::UKMailError, 'API key is invalid.'
        else
          raise UKMail::UKMailError, 'Unknown authorization error.'
        end
      end

      if response.status == 400
        error_message = JSON.parse(response.body)['Errors'].values.join("\n")
        raise UKMail::UKMailError, error_message
      end

      if response.status != 200
        raise UKMail::UKMailError, 'Unknown error.'
      end

      body = JSON.parse(response.body)

      consignment_number = body['identifiers'].find do |identifier|
        identifier['identifierType'] == 'consignmentNumber'
      end['identifierValue']

      labels = body['labels'].map do |label|
        Base64.decode64(label)
      end

      invoice = Base64.decode64(body['documents'].to_s)

      ConsignmentResponse.new(consignment_number, labels, invoice)
    end
  end
end
