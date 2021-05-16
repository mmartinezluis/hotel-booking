class Country < ApplicationRecord
  has_many: cities
  has_mnay :hotels, through: :cities
end
