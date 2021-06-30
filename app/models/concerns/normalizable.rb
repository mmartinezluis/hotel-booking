module Normalizable
  module Parse

    # hash Example: hash = {"lines"=>["116 WEST 28TH STREET"], "postalCode"=>"10001", "cityName"=>"NEW YORK", "countryCode"=>"US", "stateCode"=>"NY"}
    def parse_address(hash)
      address = hash.select {|key, value| value if key == "lines" || key == "postalCode" || key =="cityName"}.collect do |key, value|
        if key == "lines"
          parse_string(value[0])
        elsif key ==  "postalCode"
          "Postal Code: " + value
        else
          parse_string(value)
        end
      end.join(", ")
      self.address = address
    end
    
    # string example: string = "SPA, ACCESSIBLE_FACILITIES, SERVICE_DOGS_ALLOWED, DISABLED_ACCESSIBLE_TOILETS, HANDRAILS_BATHROOM"
    def parse_string(string)
      string.downcase.gsub("_", " ").split(" ").collect do |word|
        word[0].upcase + word[1..word.length]
      end.join(" ")
    end

    def general_parsing(string)
      self.parse_string(string)
    end

  end
end

