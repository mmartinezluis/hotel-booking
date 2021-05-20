class City < ApplicationRecord
  has_many :hotels
  has_many :users, through: :hotels
end
