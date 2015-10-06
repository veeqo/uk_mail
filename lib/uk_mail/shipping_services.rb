module UKMail
  module ShippingServices
    def self.list(parcel_type, delivery_type, postcode)
      services = SERVICES[parcel_type]

      if services.nil?
        raise(RuntimeError, "Parcel type '#{parcel_type.to_s}' is not supported by UK Mail.")
      end

      negated = PostcodeData.row_from_postcode(postcode).negated_services

      result = []
      services.each do |key,val|
        next if negated.include?(key)
        service_id = val[service_index(delivery_type)]
        next if service_id.nil?
        result << ShippingService.new(key, service_id)
      end
      result
    end

    DELIVERY_TYPES = [
      :signature_to_address_and_neighbor,
      :signature_to_address_only,
      :leave_safe_or_signature_to_neighbor
    ]

    SERVICES = {
      parcels: {
        'Next Day'               => [  1, 220, 210],
        'Next Day 09:00'         => [nil,   3, nil],
        'Next Day 10:30'         => [  9, 222, 212],
        'Next Day 12:00'         => [  2, 221, 211],
        'Afternoon'              => [ 77, 223, 213],
        'Evening'                => [ 78, 224, 214],
        'Saturday'               => [  4, 225, 215],
        'Saturday 09:00'         => [nil,   5, nil],
        'Saturday 10:30'         => [  7, 226, 216],
        'Timed Delivery'         => [nil,   6, nil],
        '48 Hour'                => [ 48, nil, nil],
        '48 Hour Pack'           => [ 75, nil, nil],
        '72 Hour'                => [nil, nil,  72],
        'Pallet 24 Hours'        => [nil,  97, nil],
        'Pallet 48 Hours'        => [nil,  98, nil],
        'Collection Point'       => [nil,  90, nil],
        'Collection Point 09:00' => [nil,  92, nil],
        'Collection Point 12:00' => [nil,  91, nil]
      },
      bagit_small: {
        'Next Day'               => [ 40, 240, 230],
        'Next Day 09:00'         => [nil,  42, nil],
        'Next Day 10:30'         => [ 49, 242, 232],
        'Next Day 12:00'         => [ 41, 241, 231],
        'Afternoon'              => [243, nil, 233],
        'Evening'                => [244, nil, 234],
        'Saturday'               => [ 43, 245, 235],
        'Saturday 09:00'         => [nil,  45, nil],
        'Saturday 10:30'         => [ 46, 246, 236],
        'Timed Delivery'         => [nil,  45, nil],
        '48 Hour'                => [ 48, nil, nil],
        '72 Hour'                => [nil, nil,  72],
      },
      bagit_medium: {
        'Next Day'               => [ 30, 250, nil],
        'Next Day 09:00'         => [nil,  32, nil],
        'Next Day 10:30'         => [ 39, 252, nil],
        'Next Day 12:00'         => [ 31, 251, nil],
        'Afternoon'              => [253, nil, nil],
        'Evening'                => [254, nil, nil],
        'Saturday'               => [ 33, 255, nil],
        'Saturday 09:00'         => [nil,  34, nil],
        'Saturday 10:30'         => [ 36, 256, nil],
        'Timed Delivery'         => [nil,  35, nil],
        '48 Hour'                => [ 48, nil, nil],
        '72 Hour'                => [nil, nil,  72]
      },
      bagit_large: {
        'Next Day'               => [ 20, 260, nil],
        'Next Day 09:00'         => [nil,  32, nil],
        'Next Day 10:30'         => [ 39, 252, nil],
        'Next Day 12:00'         => [ 31, 251, nil],
        'Afternoon'              => [253, nil, nil],
        'Evening'                => [254, nil, nil],
        'Saturday'               => [ 33, 255, nil],
        'Saturday 09:00'         => [nil,  34, nil],
        'Saturday 10:30'         => [ 36, 256, nil],
        'Timed Delivery'         => [nil,  25, nil],
        '48 Hour'                => [ 48, nil, nil],
        '72 Hour'                => [nil, nil,  72]
      },
      bagit_xl: {
        'Next Day'               => [ 10, 270, nil],
        'Next Day 09:00'         => [nil,  12, nil],
        'Next Day 10:30'         => [ 19, 272, nil],
        'Next Day 12:00'         => [ 11, 271, nil],
        'Afternoon'              => [273, nil, nil],
        'Evening'                => [274, nil, nil],
        'Saturday'               => [ 13, 275, nil],
        'Saturday 09:00'         => [nil,  14, nil],
        'Saturday 10:30'         => [ 16, 276, nil],
        'Timed Delivery'         => [nil,  15, nil],
        '48 Hour'                => [ 48, nil, nil],
        '72 Hour'                => [nil, nil,  72],
      }
    }

    def self.service_index(delivery_type)
      index = DELIVERY_TYPES.index(delivery_type.to_sym)
      if index.nil?
        raise(RuntimeError, "Delivery type '#{delivery_type.to_s}' is not supported by UK Mail.")
      end
      index
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
