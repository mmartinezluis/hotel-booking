class Reservation < ApplicationRecord
  belongs_to :hotel
  belongs_to :user
  has_one :room
  has_one :review
  
  # Method used in the select fields of the new review form 
  def hotel_and_checkin
    "#{self.hotel.name}, check-in: #{self.checkin_date}"
  end
  
end
