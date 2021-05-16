class Hotel < ApplicationRecord
  has_many :reservations
  has_many :users, through: :reservations
  has_many :reviews, through: :reservations
  accepts_nested_attributes_for :reservations
  belongs_to :city
end
