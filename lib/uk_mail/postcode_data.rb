require 'csv'

module UKMail
  module PostcodeData
    COLUMNS = [
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
      :service_pallets,
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
      service_saturday_10_30am: ['Saturday 10:30'],
      service_pallets:          ['Pallet 24 Hours', 'Pallet 48 Hours']
    }

    def self.column_index(column)
      COLUMNS.index(column.to_sym)
    end

    def self.row_from_postcode(postcode)
      postcode_key = postcode_as_key(postcode)
      postcode_index = column_index(:postcode)
      path = UKMail.config.postcode_dat_path

      # TODO: This can be much faster (the list is sorted by postcode)
      row_array = CSV.foreach(path, col_sep: '|') do |row|
        break row if row[postcode_index] == postcode_key
      end

      if row_array.nil?
        raise(RuntimeError, "Postcode '#{postcode.to_s.upcase}' is not supported by UK Mail.")
      end

      Row.new(row_array)
    end

    def self.postcode_as_key(uk_postcode)
      uk_postcode.delete!(' ')
      uk_postcode.upcase!
      inner = uk_postcode.length < 5 ? ' ' : uk_postcode.slice!(-3,3)[0]
      uk_postcode[0..3].ljust(4,' ') + inner
    end

    class Row
      def initialize(row_array)
        @array = row_array
      end

      COLUMNS.each do |column_sym|
        define_method(column_sym) do
          @array[PostcodeData.column_index(column_sym)]
        end
      end

      def negated_services
        SERVICE_NEGATIONS.map do |key,value|
          value if @array[PostcodeData.column_index(key)] == '1'
        end.compact.flatten
      end
    end
  end
end
