class User < ApplicationRecord
  has_many :reservations
  has_many :hotels, through: :reservations
  has_many :cities, through: :hotels
  has_many :reviews, through: :reservations
  # accepts_nested_attributes_for :reservations
  
  def booked_reservations(hotel)
    self.reservations.where("hotel_id = ?", hotel.id).order(checkin_date: :desc)
  end

  def hotels_by_city(city_id)
    self.hotels.where("city_id = ?", city_id).distinct
  end
    
end
