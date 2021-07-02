class CitiesController < ApplicationController

  def index
    @cities = current_user.cities
  end

  def datalist
    # this route is used to populate the datalist for the hotel search form via Javascript
    cities = City.all
    render json: cities, except: [:created_at, :updated_at]
  end
  
end