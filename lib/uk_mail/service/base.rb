require 'uk_mail/session'

module UKMail
  module Service
    class Base
      def initialize(session)
        @session = session
      end

      def soap_service
        raise NotImplementedError
      end

      def service
        @service ||= soap_service.new
      end
    end
  end
end
