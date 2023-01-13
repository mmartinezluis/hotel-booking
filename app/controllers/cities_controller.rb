class CitiesController < ApplicationController

  def index
    # @cities = @user.cities.distinct.includes(hotels: [:reservations]).order("reservations.checkin_date desc")
    city_ids = CityTracker.retrieve_cities_list(@user)
    @cities = City.find(city_ids)
  end

  def datalist
    # this route is used to populate the city name datalist for the hotel search form via Javascript
    # cities = City.all
    # render json: cities, except: [:created_at, :updated_at]
    render json: CityTracker.retrieve_city_codes
  end
  
end