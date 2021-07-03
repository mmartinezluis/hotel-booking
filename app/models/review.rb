class Review < ApplicationRecord
  belongs_to :reservation
  validates :description, presence: true, on: [:create, :update]

  def creation_time
    self.created_at.strftime("%e %b, %Y")
  end

end
