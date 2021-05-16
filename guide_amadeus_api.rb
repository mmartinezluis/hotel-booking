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