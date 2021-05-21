class User < ApplicationRecord
  has_many :reservations
  has_many :hotels, through: :reservations
  has_many :cities, through: :hotels
  has_many :reviews, through: :reservations
  # accepts_nested_attributes_for :reservations
  
end
