require 'yaml'

module UKMail
  module ShippingServices

    # TODO: Messy. Move to class and have service_data as a variable.

    def self.list(parcel_type, delivery_type, postcode)
      service_data = load_service_data
      services = service_data['services'][parcel_type]

      if services.nil?
        raise(RuntimeError, "Parcel type '#{parcel_type.to_s}' is not supported.")
      end

      negated = PostcodeData.row_from_postcode(postcode).negated_services

      result = []
      services.each do |key,val|
        next if negated.include?(key)
        service_id = val[service_index(service_data, delivery_type)]
        next if service_id.nil?
        result << ShippingService.new(key, service_id)
      end
      result
    end

    private

    def self.service_index(service_data, delivery_type)
      index = service_data['delivery_types'].index(delivery_type)
      if index.nil?
        raise(RuntimeError, "Delivery type '#{delivery_type}' is not supported.")
      end
      index
    end

    def self.load_service_data
      YAML.load_file(UKMail.config.service_data_path)
    end

    class ShippingService
      attr_accessor :name
      attr_accessor :id

      def initialize(name, id)
        @name = name
        @id = id
      end
    end
  end
end
