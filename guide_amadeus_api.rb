#  GUIDE ON USING THE AMADEOUS API

# Hotel Search
# Get list of hotels by cityCode
amadeus.shopping.hotel_offers.get(cityCode: 'MAD')
# Get list of offers for a specific hotel
amadeus.shopping.hotel_offers_by_hotel.get(hotelId: 'IALONCHO')
# Confirm the availability of a specific offer
amadeus.shopping.hotel_offer('D5BEE9D0D08B6678C2F5FAD910DC110BCDA187D21D4FCE68ED423426D0A246BB').get

response = amadeus.reference_data.locations.get(
  keyword: 'LON',
  subType: Amadeus::Location::ANY
)

p response.body #=> The raw response, as a string
p response.result #=> The body parsed as JSON, if the result was parsable
p response.data #=> The list of locations, extracted from the JSON

# Example: hotels from Madrid
hotels_madrid = amadeus.shopping.hotel_offers.get(cityCode: 'MAD')


hote_hash = 
   {"type"=>"hotel-offers",
 "hotel"=>
  {"type"=>"hotel",
   "hotelId"=>"WHLON464",
   "chainCode"=>"WH",
   "dupeId"=>"700148725",
   "name"=>"W London",
   "rating"=>"5",
   "cityCode"=>"LON",
   "latitude"=>51.51077,
   "longitude"=>-0.13169,
   "hotelDistance"=>{"distance"=>0.6, "distanceUnit"=>"KM"},
   "address"=>{"lines"=>["10 WARDOUR STREET"], "postalCode"=>"W1D 6QF", "cityName"=>"LONDON", "countryCode"=>"GB"},
   "contact"=>{"phone"=>"+44 20 7758 1000", "fax"=>"+44 20 7758 1001", "email"=>"Whatever.Whenever@whotels.com"},
   "description"=>
    {"lang"=>"en",
     "text"=>
      "Located in Soho, W London owns the stage in the epicenter of the citys cultural core. Plugged into the pulse of Londons energetic social scene, this is where louder-than-life Soho mixes with the glitzy West End. Tune-in to a contradictory lifestyle of RETOX/DETOX in one of the 192 guestrooms or suites, suited and booted in playful design with touches of cool Britannia. Mix and mingle over Londons playful brunch, quirky afternoon tea or innovative cocktails at The Perception. Energize at FIT, then recharge at AWAY® Spa before premiering your blockbuster in our Screening Room. Our Whatever/Whenever® service takes care of everything else."},
   "amenities"=>
    ["SPA",
     "SAUNA",
     "ACCESSIBLE_FACILITIES",
     "SERVICE_DOGS_ALLOWED",
     "DISABLED_ACCESSIBLE_TOILETS",
     "HANDRAILS_BATHROOM",
     "CONCIERGE",
     "SAFE_DEPOSIT_BOX",
     "EXCHANGE_FACILITIES",
     "FRONT_DESK",
     "24_HOUR_FRONT_DESK",
     "ONSITE_LAUNDRY",
     "EXPRESS_CHECK_IN",
     "LOUNGE",
     "HAIRDRESSER",
     "FLORIST",
     "LAUNDRY_SERVICE",
     "EXPRESS_CHECK_OUT",
     "WEDDING_SERVICES",
     "CAR_RENTAL",
     "GYM",
     "RESTAURANT",
     "HIGH_SPEED_INTERNET",
     "FREE_INTERNET",
     "HIGH_SPEED_WIRELESS",
     "WIRELESS_CONNECTIVITY",
     "ELEVATOR",
     "PETS_ALLOWED",
     "PHOTOCOPIER",
     "PRINTER",
     "BUSINESS_CENTER",
     "MEETING_FACILITIES",
     "HIGH_SPEED_INTERNET_IN_ROOM",
     "WI-FI_IN_ROOM",
     "NON_SMOKING_ROOMS",
     "TEA/COFFEE_MAKER",
     "ALARM_CLOCK",
     "AIR_CONDITIONING",
     "HAIR_DRYER",
     "IRON/IRON_BOARD",
     "ROLLAWAY_BEDS",
     "OUTLET_ADAPTERS",
     "TELEVISION",
     "CABLE_TELEVISION",
     "DVD_PLAYER",
     "VOICEMAIL_IN_ROOM",
     "DIRECT_DIAL_PHONE",
     "CORDLESS_PHONE",
     "SAFE",
     "CRIBS_AVAILABLE",
     "FITNESS_CENTER"],
   "media"=>
    [{"uri"=>"http://uat.multimediarepository.testing.amadeus.com/cmr/retrieve/hotel/3A7CE6B4EF7C42F08A0920E17A1B1377",
      "category"=>"EXTERIOR"}]},
 "available"=>true,
 "offers"=>
  [{"id"=>"7XHPGT30US",
    "checkInDate"=>"2021-05-17",
    "checkOutDate"=>"2021-05-18",
    "rateCode"=>"S9R",
    "rateFamilyEstimated"=>{"code"=>"SRS", "type"=>"C"},
    "room"=>
     {"type"=>"XMI",
      "typeEstimated"=>{"category"=>"STANDARD_ROOM", "beds"=>1, "bedType"=>"KING"},
      "description"=>
       {"text"=>
         "Marriott Senior Discount, 62 years and older valid ID required\nWonderful Room, 1 King, Bathrooms: 1, Mini frid\nge, 27sqm/291sqft-31sqm/334sqft, Wireless inter"}},
    "guests"=>{"adults"=>2},
    "price"=>
     {"currency"=>"GBP",
      "total"=>"300.00",
      "variations"=>{"average"=>{"base"=>"300.00"}, "changes"=>[{"startDate"=>"2021-05-17", "endDate"=>"2021-05-18", "total"=>"300.00"}]}},
    "policies"=>{"paymentType"=>"guarantee", "cancellation"=>{"deadline"=>"2021-05-16T23:59:00+01:00"}}}],
 "self"=>
  "https://test.api.amadeus.com/v2/shopping/hotel-offers/by-hotel?hotelId=WHLON464&adults=2&checkInDate=2021-05-17&checkOutDate=2021-05-18"}


  hote_with_irregular_room =
  "available"=>true,
  "offers"=>
   [{"id"=>"HT72BBFWJ1",
     "checkInDate"=>"2021-05-17",
     "checkOutDate"=>"2021-05-18",
     "rateCode"=>"S9R",
     "rateFamilyEstimated"=>{"code"=>"SRS", "type"=>"C"},
     "room"=>
      {"type"=>"XMI",
       "description"=>
        {"text"=>
          "Marriott Senior Discount, includes see Rate Rules\nWonderful King, High Ceiling, Full Length Mirro\nrSpacious Wrk Station, Wireless Sound Sys, 1 Ki",
         "lang"=>"EN"}},
     "guests"=>{"adults"=>2},
     "price"=>
      {"currency"=>"USD",
       "base"=>"319.20",
       "total"=>"369.78",
       "variations"=>{"average"=>{"base"=>"319.20"}, "changes"=>[{"startDate"=>"2021-05-17", "endDate"=>"2021-05-18", "base"=>"319.20"}]}},
     "policies"=>
      {"paymentType"=>"guarantee",
       "cancellation"=>
        {"description"=>{"text"=>"2021-05-16T23:59:00\nCancel Penalty Amount: 369.78 "},
         "amount"=>"369.78",
         "deadline"=>"2021-05-16T23:59:00-04:00"}}}],
  "self"=>"https://test.api.amadeus.com/v2/shopping/hotel-offers/by-hotel?hotelId=WHNYC299&adults=2"},