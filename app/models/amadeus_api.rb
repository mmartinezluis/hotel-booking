require 'amadeus'
class AmadeusApi 
  attr_accessor :amadeus
  @@all = []
  @@collection = []

  def initialize()
    @amadeus = Amadeus::Client.new({
        client_id: "#{ENV['AMADEUS_API_KEY']}",
        client_secret: "#{ENV['AMADEUS_API_SECRET']}"
      })
    self << @@all
    city = City.find_or_create_by(code: "LON", name: "London")
    user = User.find_or_create_by(first_name: "Luis", last_name: "M")
  end

  def self.all
    @@all
  end

  def hotels
    @@collection
  end

  def query_city(citycode, checkin_date = Date.today.to_s, checkout_date = (Date.today+1).to_s, guests = 2)
    begin
      response = @amadeus.shopping.hotel_offers.get(
        cityCode: citycode,
        checkInDate: checkin_date,
        checkOutDate: checkout_date,
        adults: guests
      ).data
    rescue StandardError => e
      flash[:msg] = "#{e.class}: #{e.message}. Please try again..."
      redirect_to root_path
    end
    parse_city_responnse(response)
  end

  def parse_city_responnse(response)
    response.each do |hotel_hash|
      @@collection << Hotel.build_hotel(hotel_hash)
    end
    @@collection
  end

  def query_reservation(offerId)
    reservation_query = @amadeus.shopping.hotel_offer("#{offerId}").get.data
    parse_reservation_query = reservation_query
  end



  

end
