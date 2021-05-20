class User < ApplicationRecord
  has_many :reservations
  has_many :hotels, through: :reservations
  has_many :reviews, through: :reservations
  has_many :cities, through: :reservations, :source => :code
  accepts_nested_attributes_for :reservations

  def visited_cities
    self.joins(:cities)
  end

  
end
