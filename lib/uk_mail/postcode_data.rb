require 'csv'

module UKMail
  module PostcodeData
    MASTER = CSV.read('Postcode.dat', col_sep: '|') # TODO: Get this file from config

    COLUMN_INDICES = [
      :hub_letter,
      :town,
      :county,
      :postcode,
      :zone,
      :service_9am,
      :service_10_30am,
      :service_am,
      :service_next_day,
      :service_48_hour,
      :primary_sort,
      :secondary_sort,
      :latest_notification_time,
      :latest_collection_time,
      :service_home_am,
      :service_home_pm,
      :service_home_evening,
      :locality,
      :postcode_version,
      :service_saturday,
      :service_saturday_9am,
      :service_saturday_10_30am,
      :pallets,
      :courier_depot_code
    ]

    SERVICE_NEGATIONS = {
      service_9am:              ['Next Day 09:00'],
      service_10_30am:          ['Next Day 10:30'],
      service_am:               ['Next Day 12:00'],
      service_next_day:         ['Next Day'],
      service_48_hour:          ['48 Hour', '72 Hour'], # TODO: 72 Hour? Really?
      service_home_am:          [], # \
      service_home_pm:          [], #  TODO: Investigate. From email: "These are retail services - Not to be used for Domestic"
      service_home_evening:     [], # /
      service_saturday:         ['Saturday'],
      service_saturday_9am:     ['Saturday 09:00'],
      service_saturday_10_30am: ['Saturday 10:30']
    }

    def self.column_index(column)
      COLUMN_INDICES.index(column.to_sym)
    end

    def self.row_from_postcode(postcode)
      postcode = postcode_as_key(postcode)
      row_array = MASTER.find { |row| row[column_index(:postcode)] == postcode }
      Row.new(row_array)
    end

    def self.postcode_as_key(uk_postcode)
      uk_postcode.delete!(' ')
      uk_postcode.upcase!
      inner = uk_postcode.slice!(-3,3)
      uk_postcode[0..3].ljust(4,' ') + inner[0]
    end

    class Row
      def initialize(row_array)
        @array = row_array
      end

      def negated_services
        SERVICE_NEGATIONS.map do |key,value|
          value if @array[PostcodeData.column_index(key)] == '1'
        end.compact.flatten
      end
    end
  end
end
