module UKMail
  class IrelandData
    IRELAND_COUNTY_PREFIXES = %w[County Cnty CC. CC Ct. Ct Co. Co C.]
    IRELAND_COUNTIES = %w[
      Carlow Cavan Clare Cork Donegal Dublin Galway Kerry Kildare Kilkenny Laois Leitrim
      Limerick Longford Louth Mayo Meath Monaghan Offaly Roscommon Sligo Tipperary Waterford
      Westmeath Wexford Wicklow
    ]

    def initialize(county, postcode)
      @county = county.to_s.strip.downcase
      @postcode = postcode.to_s.strip.downcase
    end

    def ireland_county
      @ireland_county ||=
      begin
        IRELAND_COUNTY_PREFIXES.each do |prefix|
          @county.gsub!(/^#{Regexp.escape(prefix.downcase)} /i, '')
        end
        @county.capitalize!
        @county if IRELAND_COUNTIES.include?(@county)
      end
    end

    def ireland_postcode
      @ireland_postcode ||=
      if ireland_county == 'Dublin'
        dublin_postcode
      else
        row = PostcodeData.row_from_county(ireland_county)
        row.nil? ? nil : row.postcode.strip
      end
    end

    private

    def dublin_postcode
      if match = /^(d|dublin)? *(\d+)$/.match(@postcode)
        'D' + match.captures[1].to_i.to_s
      end
    end
  end
end
