class Reservation < ApplicationRecord
  belongs_to :hotel
  belongs_to :user
  has_one :room
  has_one :review
  # accepts_nested_attributes_for :room
  def hotel_and_checkin
    "#{self.hotel.name}, check-in: #{self.checkin_date}"
  end
  
end
