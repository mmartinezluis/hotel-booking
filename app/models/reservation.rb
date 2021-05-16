class Reservation < ApplicationRecord
  belongs_to :hotel
  belongs_to :user
  has_one :room
end
