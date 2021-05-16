require 'amadeus'
class AmadeusApi 
  attr_accessor :amadeus

  def initialize()
    @amadeus = Amadeus::Client.new({
        client_id: "#{ENV['AMADEUS_API_KEY']}",
        client_secret: "#{ENV['AMADEUS_API_SECRET']}"
      })
  end
    
#   def load_api
#     amadeus = Amadeus::Client.new({
#       client_id: "#{ENV['AMADEUS_API_KEY']}",
#       client_secret: "#{ENV['AMADEUS_API_SECRET']}"
#     })
#   end

  def base_URL
  end

  def query_city(citycode)
    response = @amadeus.shopping.hotel_offers.get(cityCode: "#{citycode}").data
    # parse_city_responnse(response)
  end

#   def query_hotel(hotelId)
#     hotel_query = amadeus.shopping.hotel_offers_by_hotel.get(hotelId: "#{hotelId}").data
#     parse_hotel_query (hote_query)
#   end

  def query_reservation(offerId)
    reservation_query = @amadeus.shopping.hotel_offer("#{offerId}").get.data
    parse_reservation_query = reservation_query
  end

  def parse_city_responnse(response)
    collection = []
    response.each do |hotel|
      collection << hotel
      
      response[0]["hotel"]["hotelId"]
      response[0]["hotel"]["citycode"]
      response[0]["hotel"]["name"]
      response[0]["hotel"]["latitude"]
      response[0]["hotel"]["longitude"]
      response[0]["hotel"]["address"]
      response[0]["hotel"]["description"]["text"]
      response[0]["hotel"]["amenities"]
      #  Build nested reservation at this point
      response[0]["offers"]
      response[0]["offers"][0]["id"]                    # Reservation code in schema, reservations
      response[0]["offers"][0]["guests"]["adults"]      # Number of guests
      response[0]["offers"][0]["price"]["currency"]     # Currency
      response[0]["offers"][0]["price"]["total"]        # Total price
      response[0]["offers"][0]["checkInDate"]           # Checkin date
      response[0]["offers"][0]["checkOutDate"]          # Checkout date
      response[0]["offers"][0]["room"]["typeEstimated"] # All room info
      
    Hotel.build_hotels()
  end

end
