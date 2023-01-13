class CitiesController < ApplicationController

  def index
    @cities = current_user.cities.distinct.includes(hotels: [:reservations]).order("reservations.checkin_date desc")
  end

  def datalist
    # this route is used to populate the city name datalist for the hotel search form via Javascript
    # cities = City.all
    # render json: cities, except: [:created_at, :updated_at]
    render json: CityTracker.retrieve_cities
  end
  
end