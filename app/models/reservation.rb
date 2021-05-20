class Reservation < ApplicationRecord
  belongs_to :hotel
  belongs_to :user
  belongs_to :city
  has_one :room
  # accepts_nested_attributes_for :room
  has_one :review
end
