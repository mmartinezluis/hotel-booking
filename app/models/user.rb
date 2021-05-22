class User < ApplicationRecord
  has_many :reservations
  has_many :hotels, through: :reservations
  has_many :cities, through: :hotels
  has_many :reviews, through: :reservations
  # accepts_nested_attributes_for :reservations
  
  # For the current user, find the user's upcoming or visited hotels for the given city
  def hotels_by_city(city_id)
    self.hotels.where("city_id = ?", city_id).distinct
  end

  # def find_hotel(hotel)
  #   self.hotels.find_by(hotelId: new_hotel.hotelId)
  # end

  # def unbooked_reservation(hotel)
  #   self.hotels
  # end
  
 


    
end
