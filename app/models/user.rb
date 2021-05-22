class User < ApplicationRecord
  has_many :reservations
  has_many :hotels, through: :reservations
  has_many :cities, through: :hotels
  has_many :reviews, through: :reservations
  # accepts_nested_attributes_for :reservations

  # Used by the API to show a hotel reservation offer
  # This method needs to be changed to ".find" instead of ".select" at a later point
  def unbooked_reservation(hotel)
    hotel.reservations.select { |reservation| reservation.id == nil && reservation.user_id = self.id}
  end

  # For the current user, find the user's reservations for the given hotel, and order them from most recent to least recent checkin date
  def booked_reservations(hotel)
    self.reservations.where("hotel_id = ?", hotel.id).order(checkin_date: :desc)
  end

  def most_recent_reservation(hotel)
    booked_reservations(hotel).first
  end
  
  # For the current user, find the user's hotels for the given city and sort them by most recent checkin date
  def hotels_by_city(city_id)
    #self.hotels.where("city_id = ?", city_id).distinct
    self.hotels.where("city_id = ?", city_id).distinct.sort do |hotel_1, hotel_2| 
      self.most_recent_reservation(hotel_2).checkin_date <=> self.most_recent_reservation(hotel_1).checkin_date
    end
  end

  def all_reservations
    self.reservations.order(checkin_date: :desc)
  end

  def upcoming_reservations(hotel)
    booked_reservations(hotel).where("checkin_date >= :todays_date", {todays_date: Date.today.to_s})
  end

  def previous_reservations(hotel)
    booked_reservations(hotel).where("checkin_date < :todays_date", {todays_date: Date.today.to_s})
  end
 
    
end
