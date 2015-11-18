module UKMail
  module Service
    class ServiceBase
      attr_accessor :session

      def initialize(session)
        @session = session
      end

      protected

      def soap_service
        raise NotImplementedError
      end

      def make_request(request_class, params)
        request = request_class.new(self, params)
        request.build
        handle_validation_errors(request.validation_errors)
        response = request.get_response
        handle_uk_mail_errors(response) if response.result != 'Successful'
        response
      end

      def handle_validation_errors(validation_errors)
        missing_fields = validation_errors[:missing]
        return if missing_fields.nil? || missing_fields.empty?
        message = 'The following required fields are missing or empty: ' + missing_fields.join(', ')
        raise UKMail::ValidationError, message
      end

      def handle_uk_mail_errors(response)
        message = response.errors.map do |error|
          "#{error.code}: #{error.description}"
        end.join("\n")
        raise UKMail::UKMailError, message
      end
    end
  end
end
