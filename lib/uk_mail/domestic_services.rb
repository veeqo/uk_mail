require 'yaml'

module UKMail
  module DomesticServices
    def self.list(parcel_type, delivery_type, country, county, postcode)
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
        service_id = val[index_for_delivery_type(service_data, delivery_type)]
        next nil if service_id.nil?
        DomesticService.new(key, service_id)
      end.compact
    end

    def self.all_service_names
      service_data['services'].flat_map{|k,v| v.keys }.uniq
    end

    def self.all_parcel_types
      service_data['services'].keys
    end

    def self.all_delivery_types
      service_data['delivery_types'].map{|delivery_type| delivery_type['name'] }.uniq
    end

    def self.api_version
      service_data['version']
    end

    def self.signature_optional_for_service_key(service_key)
      if service_key.nil?
        raise(UKMail::ServiceError, "Service key is required.")
      end

      index = index_for_service_key(service_data, service_key)

      if index.nil?
        raise(UKMail::ServiceError, "Service key '#{service_key}' is not supported.")
      end

      service_data['delivery_types'][index]['signature_optional']
    end

    private

    def self.index_for_delivery_type(service_data, delivery_type)
      index = service_data['delivery_types'].index{ |dt| dt['name'] == delivery_type }
      if index.nil?
        raise(UKMail::ServiceError, "Delivery type '#{delivery_type}' is not supported.")
      end
      index
    end

    def self.service_data
      @service_data ||= YAML.load_file(UKMail.config.service_data_path)
    end

    def self.index_for_service_key(service_data, service_key)
      all_services = service_data['services'].map{ |k,v| v.map{ |k,v| v } }.reduce(:+)
      all_services.each do |service_group|
        index = service_group.index(service_key)
        return index unless index.nil?
      end
      nil
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
