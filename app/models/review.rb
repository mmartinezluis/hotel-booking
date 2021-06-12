class Review < ApplicationRecord
  belongs_to :reservation
  validates :description, presence: true, on: [:create, :update]

  scope :from_user, ->(user) { joins(:reservations).where("user_id = :current_user", {current_user: user.id}) }  # Not used
end
