module UKMail
  module Service
    class Base
      def initialize(session)
        @session = session
      end

      protected

      def soap_service
        raise NotImplementedError
      end

      def service
        @service ||= soap_service.new
      end

      def parameters(*args)
        missing_fields = []
        args.map! do |arg|
          if is_blank?(arg[:value])
            missing_fields << arg[:name] unless arg.has_key?(:default)
            arg[:default]
          else
            arg[:value]
          end
        end
        check_and_raise_missing_fields(missing_fields)
        args
      end

      def is_blank?(var)
        var.respond_to?(:empty?) ? !!var.empty? : !var
      end

      def check_and_raise_missing_fields(missing_fields)
        return if missing_fields.empty?
        message = 'The following required fields are missing or empty: ' + missing_fields.join(', ')
        raise UKMail::ValidationError, message
      end
    end
  end
end
