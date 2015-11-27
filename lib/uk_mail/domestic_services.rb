require 'yaml'

module UKMail
  module DomesticServices
    def self.list(parcel_type, delivery_type, country, county, postcode)
      service_data = load_service_data
      services = service_data['services'][parcel_type]

      if services.nil?
        raise(UKMail::ServiceError, "Parcel type '#{parcel_type.to_s}' is not supported.")
      end

      if country && ['IE','IRL','IRELAND'].include?(country.upcase)
        postcode = IrelandData.new(county, postcode).ireland_postcode
        if postcode.nil?
          raise(UKMail::ServiceError, "Ireland County and/or Postcode are invalid.")
        end
      end

      negated = PostcodeData.row_from_postcode(postcode).negated_services

      services.map do |key,val|
        next nil if negated.include?(key)
        service_id = val[service_index(service_data, delivery_type)]
        next nil if service_id.nil?
        DomesticService.new(key, service_id)
      end.compact
    end

    def self.api_version
      load_service_data['version']
    end

    private

    def self.service_index(service_data, delivery_type)
      index = service_data['delivery_types'].index(delivery_type)
      if index.nil?
        raise(UKMail::ServiceError, "Delivery type '#{delivery_type}' is not supported.")
      end
      index
    end

    def self.load_service_data
      YAML.load_file(UKMail.config.service_data_path)
    end

    class DomesticService
      attr_accessor :name
      attr_accessor :key

      def initialize(name, key)
        @name = name
        @key = key
      end
    end
  end
end
