class HotelsController < ApplicationController
#   before_action :set_api 
#   before_action :set_hotel, only: [:show, :reserve]
#   before_action :verify_params

  def index
    # If the city_hotels nested route is used, display hotels from the nested city only
    if params[:city_id]
      @nested_city = City.user_cities(current_user).find_by(id: params[:city_id])
      if @nested_city.nil?
        flash[:msg] = "City not found."
        redirect_to cities_path
      end
      @hotels = current_user.hotels_by_city(params[:city_id])
    # If the user_hotels nested route is used, display the user's hotels
    elsif params[:user_id]
      nested_user = User.find_by(id: params[:user_id])
      redirect_to hotels_path alert: "Users can only see their own hotels." and return if current_user != nested_user
      @nested_user = params[:user_id]
      @hotels = current_user.all_hotels
    else
      # If no nested route, load the API for searching hotels
      api = AmadeusApi.all.last
      api ||= AmadeusApi.new
      AmadeusApi.hotels.clear
      user_id = current_user.id
      if params[:city] && !params[:city].blank?
        begin
          if params[:checkin_date].blank? && params[:checkout_date].blank? && params[:guests].blank?
            @hotels = api.query_city(params[:city], user_id)
          else
            @hotels = api.query_city(params[:city], params[:checkin_date], params[:checkout_date], params[:guests], user_id)
          end
        rescue StandardError => e
          flash[:msg] = "#{e.class}: #{e.message}. Please try again..."
          render :'index.html.erb' and return
        end
        if @hotels.empty?
          flash[:msg] = "Ooops, no hotels could be found for the requested specifications"
        end
      end
    end
  end

  def show
    # If request comes from the 'city_hotels' nested route, show the hotel from the database by city id and hotel id
    if params[:city_id]
      city = City.user_cities(current_user).find_by(id: params[:city_id])
      if city.nil? 
        flash[:msg] = "City not found."
        redirect_to cities_path and return 
      else
        @hotel = current_user.hotels.find_by(id: params[:id], city_id: params[:city_id])
        if @hotel.nil?
          flash[:msg] = "Hotel not found for this city." 
          redirect_to city_hotels_path(city) and return
        end
      end
    # If request comes from 'hotel_path', show the hotel from the database by user id and hotel id
    elsif params[:id]  
      @hotel = current_user.find_hotel(params[:id])
      if @hotel.nil?
        flash[:msg] = "Hotel not found." 
        redirect_to user_hotels_path(current_user) and return
      end
    # If no nested city or no nested user, show the hotel using the hotelId from the API
    elsif params[:hotelId]
      @hotel = AmadeusApi.hotels.find { |hotel| hotel.hotelId == params[:hotelId] }
      if @hotel.nil?
        flash[:msg] = "Hotel not found." 
        redirect_to hotels_path
      end
    end
  end

  def reserve
    api = AmadeusApi.all.last
    @hotel = AmadeusApi.hotels.find { |hotel| hotel.hotelId == params[:hotelId] }
    # 'reservation', below, can cause an exception 
    begin
      # Use the hotel_offer API endpoint to check in real-time whether the reservation still exists 
      reservation = api.amadeus.shopping.hotel_offer(params[:code]).get.data 
    rescue StandardError => e
      flash[:msg] = "#{e.class}: #{e.message}. Please try again..."
      redirect_to root_path
    else 
      # If no exception is raised, check whether reservertion is avaiable
      if reservation && reservation["available"]  == true
        # Check that the reservation attributes did not change since first time reservation was displayed
        checkin = reservation["offers"][0]["checkInDate"] == @hotel.last_reservation.checkin_date
        checkout = reservation["offers"][0]["checkOutDate"] == @hotel.last_reservation.checkout_date
        guests = reservation["offers"][0]["guests"]["adults"] == @hotel.last_reservation.guests
        # price = reservation["offers"][0]["price"]["total"] == @hotel.last_reservation.price
        if checkin && checkout && guests #&& price
          AmadeusApi.hotels.clear
          @hotel.save
          flash[:msg] = "Congratualtions! Your reservation was successfully processed."
          redirect_to hotel_search_path
        else
          flash[:msg]= "Sorry, one or more of the reservation conditions have changed. Please retry your hotel search."
          render :'show.html.erb' and return
        end
      else
        flash[msg] = "Ooops, the reservation has already been booked."
        render :'show.html.erb' and return
      end
    end
  end

  private

#   def set_api
#     api = AmadeusApi.all.last
#     api ||= AmadeusApi.new
#     api
#   end

#   def set_hotel
#     @hotel = api.hotels.find { |hotel| hotel.hotelId == params[:hotelId] }
#   end

    def hotel_params
      params.require(:hotel).permit(
        # params for API
        :city, :checkin_date, :checkout_date,:guests, :hotelId,
        # params from city_hotels and user_hotels nested routes
        :city_id, :user_id
      )
    end

    def verify_api_params
    end
  
end
