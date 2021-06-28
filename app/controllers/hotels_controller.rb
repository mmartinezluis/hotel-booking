class HotelsController < ApplicationController
  before_action :check_city_id, only: [:index, :show]
  before_action :check_user_id, only: [:index]

  def index
    # If the city_hotels nested route is used, display hotels from the nested city only
    # If the user_hotels nested route is used, display the user's hotels
    # If no nested route is used, load the API for searching hotels, below
    if params[:city] && !params[:city].blank?
      api = AmadeusApi.new
      AmadeusApi.hotels.clear
      user_id = current_user.id
      begin
        @hotels = api.query_city(params[:city], params[:checkin_date], params[:checkout_date], params[:guests], user_id)
      rescue StandardError => e
        flash[:msg] = "#{e.class}: #{e.message}. One or more search inputs were invalid. Please try again..."
        render :'index.html.erb' and return
      end
      if @hotels.empty?
        flash[:msg] = "Ooops, no hotels could be found for the requested specifications"
      end
    end
  end

  def show
    # If request comes from the 'city_hotels' nested route, show the hotel from the database by city id and hotel id
    # If request comes from 'hotel_path', show the hotel from the database by user id and hotel id
    if params[:id]  
      @hotel = current_user.find_hotel(params[:id])
      if @hotel.nil?
        flash[:msg] = "Hotel not found." 
        redirect_to user_hotels_path(current_user) and return
      end
    # If no nested city or no hotel from database, show the hotel using the hotelId from the API
    elsif params[:hotelId]
      @hotel = AmadeusApi.hotels.find { |hotel| hotel.hotelId == params[:hotelId] }
      if @hotel.nil?
        flash[:msg] = "Hotel not found." 
        redirect_to hotels_path
      end
    end
  end

  def reserve
    # byebug
    api = AmadeusApi.all.last
    @hotel = AmadeusApi.hotels.find { |hotel| hotel.hotelId == params[:hotelId] }
    # 'reservation', below, can cause an exception and it needs to be rescued
    begin
      # Use the HOTEL_OFFER API ENDPOINT to check in real-time whether the reservation still exists 
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
          flash[:msg] = "Congratulations! Your reservation was successfully processed."
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

    def hotel_params
      params.require(:hotel).permit(
        # params for API:
        :city, :checkin_date, :checkout_date,:guests, :hotelId,
        # params from city_hotels and user_hotels nested routes:
        :city_id, :user_id
      )
    end

    def check_city_id
      if params[:city_id]
        @nested_city = current_user.cities.find_by(id: params[:city_id])
        @hotels = current_user.hotels_by_city(params[:city_id])
        if @nested_city.nil? 
          flash[:msg] = "City not found."
          redirect_to cities_path and return    
        elsif params[:id] && current_user.hotels.find_by(id: params[:id], city_id: params[:city_id]).nil?
          flash[:msg] = "Hotel not found for this city." 
          redirect_to city_hotels_path(@nested_city) and return
        end
      end
    end

    def check_user_id
      if params[:user_id] 
        @nested_user = User.find_by(id: params[:user_id])
        @hotels = current_user.all_hotels_sorted
        if current_user != @nested_user
          flash[:msg] = "Users can only see their own hotels."
          redirect_to hotels_path and return
        end
      end
    end

end
