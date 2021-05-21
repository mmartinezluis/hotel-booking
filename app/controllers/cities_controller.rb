class CitiesController < ApplicationController

  def index
    @cities = City.user_cities(User.first.id)
  end
end