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
        check_and_raise_errors(request.validation_errors)
        request.get_response
      end

      def check_and_raise_errors(validation_errors)
        missing_fields = validation_errors[:missing]
        return if missing_fields.nil? || missing_fields.empty?
        message = 'The following required fields are missing or empty: ' + missing_fields.join(', ')
        raise UKMail::ValidationError, message
      end
    end
  end
end
