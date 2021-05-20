class Country < ApplicationRecord
  has_many :cities
  has_many :hotels, through: :cities
end
