module UKMail
  module Service
    class RequestBase
      attr_accessor :service, :params, :validation_errors, :validated_parameters

      def initialize(_service, _params)
        @service = _service
        @params = _params
        @validation_errors = {}
      end

      def get_response
        raise NotImplementedError
      end

      def build
        raise NotImplementedError
      end

      def build_group(*args)
        args.map! do |arg|
          if is_blank?(arg[:value])
            add_validation_error(:missing, arg[:name]) unless arg.has_key?(:default)
            arg[:default]
          else
            arg[:value]
          end
        end
        args
      end

      def add_validation_error(type, message)
        (@validation_errors[type] ||= []) << message
      end

      def clear_validation_errors
        @validation_errors = {}
      end

      def is_blank?(var)
        return false if var.is_a?(FalseClass)
        var.respond_to?(:empty?) ? !!var.empty? : !var
      end

      def format_date(date)
        date.utc.strftime("%Y-%m-%dT%H:%M:%S.%L")
      end

      def soap
        service.soap
      end

      def soap_service
        service.soap_service
      end
    end
  end
end
