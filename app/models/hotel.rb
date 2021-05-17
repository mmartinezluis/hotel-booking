class Hotel < ApplicationRecord
  has_many :reservations
  has_many :users, through: :reservations
  has_many :reviews, through: :reservations
  # accepts_nested_attributes_for :reservations
  belongs_to :city

  def self.build_hotel(hotel_hash)
    new_hotel = Hotel.new
    new_hotel.city_id = City.first.id
    new_hotel.hotelId = hotel_hash["hotel"]["hotelId"]
    new_hotel.citycode = hotel_hash["hotel"]["cityCode"]
    new_hotel.name = hotel_hash["hotel"]["name"]
    new_hotel.latitude = hotel_hash["hotel"]["latitude"]
    new_hotel.longitude = hotel_hash["hotel"]["longitude"]
    new_hotel.address = hotel_hash["hotel"]["address"]
    # new_hotel.description = hotel_hash["hotel"]["description"]["text"] unless hotel_hash["hotel"]["description"]["text"].nil?
    # new_hotel.amenities = hotel_hash["hotel"]["amenities"].take(5).join(", ") unless hotel_hash["hotel"]["amenities"].nil?
    #  Build nested reservation for hotel 
    new_reservation = new_hotel.reservations.build(
      code: hotel_hash["offers"][0]["id"],                    # Reservation code in schema, reservations
      guests: hotel_hash["offers"][0]["guests"]["adults"],      # Number of guests
      currency: hotel_hash["offers"][0]["price"]["currency"],     # Currency
      price: hotel_hash["offers"][0]["price"]["total"],        # Total price
      checkin_date: hotel_hash["offers"][0]["checkInDate"],           # Checkin date
      checkout_date: hotel_hash["offers"][0]["checkOutDate"],          # Checkout date
    )
    new_reservation.user_id = User.first.id
    #  Build nested room for reservation 
    new_room = new_reservation.build_room(
      category: hotel_hash["offers"][0]["room"]["typeEstimated"]["category"],
      beds: hotel_hash["offers"][0]["room"]["typeEstimated"]["beds"],
      bedtype: hotel_hash["offers"][0]["room"]["typeEstimated"]["bedType"]
    )
    new_hotel
  end

end
