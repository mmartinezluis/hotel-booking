class Review < ApplicationRecord
  belongs_to :reservation

  scope :from_user, ->(user) { joins(:reservations).where("user_id = :current_user", {current_user: user.id}) }  # Not used
end
