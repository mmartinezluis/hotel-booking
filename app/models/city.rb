class City < ApplicationRecord
  has_many :hotels
  
  # scope :user_cities, ->(user) {where:"user_id = ?", user.id}

  # def self.user_cities(current_user)
  #   joins(hotels: :reservations).where("user_id = ?", current_user).distinct
  # end

end
