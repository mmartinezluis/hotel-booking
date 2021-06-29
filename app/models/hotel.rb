class Hotel < ApplicationRecord
  has_many :reservations
  has_many :users, through: :reservations
  has_many :reviews, through: :reservations
  # accepts_nested_attributes_for :reservations
  belongs_to :city

  scope :alphabetized, -> {order(name: :asc)}
  
  # Since a hotel comes with a reservation and a room, hotels are built with both objects nested
  def self.build_hotel(hotel_hash, user_id)
    city = City.find_or_create_by(code: hotel_hash["hotel"]["cityCode"])
    hotel = Hotel.find_by(hotelId: hotel_hash["hotel"]["hotelId"])
    # If the hotel is already in the database, do not build a new hotel (skip the below block)
    unless hotel 
      hotel = Hotel.new 
      hotel.city_id = city.id
      hotel.hotelId = hotel_hash["hotel"]["hotelId"]
      hotel.citycode = hotel_hash["hotel"]["cityCode"]
      hotel.name = hotel_hash["hotel"]["name"]
      hotel.latitude = hotel_hash["hotel"]["latitude"]
      hotel.longitude = hotel_hash["hotel"]["longitude"]
      hotel.address = hotel_hash["hotel"]["address"]
      hotel.description = hotel_hash["hotel"]["description"]["text"] unless !hotel_hash["hotel"].keys.include?("description")         # Some hotels do not inlcude a description
      hotel.amenities = hotel_hash["hotel"]["amenities"].take(5).join(", ") unless !hotel_hash["hotel"].keys.include?("amenities")    # Some hotels do not include amenities
    end
    #  Build nested reservation for hotel 
    new_reservation = hotel.reservations.build(
      code: hotel_hash["offers"][0]["id"],                       # Reservation code in schema, reservations
      guests: hotel_hash["offers"][0]["guests"]["adults"],       # Number of guests
      currency: hotel_hash["offers"][0]["price"]["currency"],    # Currency
      price: hotel_hash["offers"][0]["price"]["total"],          # Total price
      checkin_date: hotel_hash["offers"][0]["checkInDate"],      # Checkin date
      checkout_date: hotel_hash["offers"][0]["checkOutDate"],    # Checkout date
    )
    new_reservation.user_id = user_id
    #  Build nested room for reservation 
    # If the hotel_hash includes the "TypeEstimated" key, build a room with 3 attributes
    if hotel_hash["offers"][0]["room"].keys.include?("typeEstimated")
      new_room = new_reservation.build_room(
        category: hotel_hash["offers"][0]["room"]["typeEstimated"]["category"],
        beds: hotel_hash["offers"][0]["room"]["typeEstimated"]["beds"],             # Number of beds
        bedtype: hotel_hash["offers"][0]["room"]["typeEstimated"]["bedType"]        # King, ect.
      )
    else
    # If the hotel_hash does not include the "TypeEstimated" key, Build a rooom with one attribute only
      new_room = new_reservation.build_room(
        category: hotel_hash["offers"][0]["room"]["description"]["text"].split("\n")[1]
      )
    end
    # Return the hotel with its nested reservation and room
    # The hotel is not persisted to database unless a reservatino is made; see hotels_controller 'reserve' method
    hotel
  end

  def last_reservation
    self.reservations.last
  end
  
end
