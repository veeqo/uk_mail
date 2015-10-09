require 'active_support/core_ext/object/blank.rb'

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
        args.map do |arg|
          value = arg[:value]
          default = arg[:default]
          default && value.blank? ? default : value
        end
      end
    end
  end
end
