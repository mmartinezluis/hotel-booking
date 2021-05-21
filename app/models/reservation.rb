class Reservation < ApplicationRecord
  belongs_to :hotel
  belongs_to :user
  has_one :room
  has_one :review
  # accepts_nested_attributes_for :room
end
