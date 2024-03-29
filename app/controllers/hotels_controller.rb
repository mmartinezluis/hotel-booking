class HotelsController < ApplicationController
  before_action :check_city_id, only: [:index, :show]
  before_action :check_user_id, only: [:index]

  def index
    # If the city_hotels nested route is used, display hotels from the nested city only (:check_city_id filter)
    # If the user_hotels nested route is used, display the user hotels (:check_user_id filter)
    # If no nested route is used, load the API for searching hotels (the below lines)
    if params[:city] && !params[:city].blank?
      city_code = filter_city_name
      api = AmadeusApi.new
      AmadeusApi.hotels.clear
      user_id = current_user.id
      flash[:msg] = ""
      begin
        @hotels = api.query_city(city_code, convert_dates[0], convert_dates[1], params[:guests], user_id)
      rescue Amadeus::ResponseError => e
        flash[:msg] = "#{e.class}: #{e.message}. Invalid city code or input value. Please try again..."
        render :'index.html.erb' and return
      end
      if @hotels.empty?
        flash[:msg] = "Ooops, no hotels could be found for the requested specifications"
      end
    end
  end

  def show
    # If request comes from the 'city/hotel' nested route, check that the city and the hotel are valid (:check_city_id filter)
    # If request comes from 'hotel_path',show the hotel from the database by user id and hotel id
    @hotel = current_user.find_hotel(params[:id])
    if @hotel.nil?
      flash[:msg] = "Hotel not found." 
      redirect_to user_hotels_path(current_user) and return
    end
  end

  def search_results
    @hotel = AmadeusApi.hotels.find { |hotel| hotel.hotelId == params[:hotelId] }
    if @hotel.nil?
      flash[:msg] = "Hotel not found." 
      redirect_to hotels_path and return
    end
    render :show
  end

  def reserve
    api = AmadeusApi.all.last
    @hotel = AmadeusApi.hotels.find { |hotel| hotel.hotelId == params[:hotelId] }
    begin
      # Use the HOTEL_OFFER API ENDPOINT to check in real-time whether the reservation is still available 
      reservation = api.amadeus.shopping.hotel_offer(params[:code]).get.data 
    rescue Amadeus::ResponseError => e
      flash[:msg] = "#{e.class}: #{e.message}. Please try again..."
      redirect_to root_path
    else 
      # If no exception is raised, check whether reservertion is avaiable
      if reservation && reservation["available"]  == true
        # Check that the reservation attributes did not change since first time reservation was displayed
        original = @hotel.reservations.last
        checkin = reservation["offers"][0]["checkInDate"] 
        checkout = reservation["offers"][0]["checkOutDate"] 
        guests = reservation["offers"][0]["guests"]["adults"] 
        # price = reservation["offers"][0]["price"]["total"] == @hotel.last_reservation.price
        if checkin == original.checkin_date && checkout == original.checkout_date && guests && original.guests #&& price
          AmadeusApi.hotels.clear
          @hotel.save
          # Update caches
          checkin = checkin.to_time.to_i
          Rails.cache.redis.with { |c| c.zadd(HotelTracker.hotels_list_cache_key(@user), checkin, @hotel.id, gt: true) } 
          Rails.cache.redis.with { |c| c.zadd(CityTracker.cities_list_cache_key(@user), checkin, @hotel.city_id, gt: true) }
          Rails.cache.redis.with { |c| c.incr(HotelTracker.upcoming_re_counter_cache_key(@user)) } 

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

  def trending
    @hotels = Hotel.most_popular
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
        if @user != @nested_user
          flash[:msg] = "Users can only see their own hotels."
          redirect_to user_hotels_path(@user) and return
        end
        # @hotels = @nested_user.all_hotels_sorted
        # todo: make retrieve+hotels_method build the hotels_list if list is empty
        hotel_ids = HotelTracker::ForUser.retrieve_hotels_list(@nested_user)
        hotel_ids = HotelTracker::ForUser.new(@nested_user).hotel_ids if hotel_ids.empty?
        @hotels = Hotel.find(hotel_ids)
        render :index and return
      end
    end

    def filter_city_name
      if params[:city].length == 3
        iatacode = params[:city]
      else
        # grab the content inside the parenthesis
        iatacode = params[:city][/\((.*?)\)/, 1]
        if !iatacode.nil? && iatacode.length < 3
          flash[:msg] = "Please select a city from the list or use the 3 letters IATA code for your desired city."
          render :'index.html.erb' and return
        end
      end
      iatacode
    end

    def convert_dates
      dates = params[:dates].split("-")
      start = dates[0].strip.split("/")
      last = dates[1].strip.split("/")
      checkin_date = "#{start[2]}-#{start[0]}-#{start[1]}"
      checkout_date = "#{last[2]}-#{last[0]}-#{last[1]}"
      [checkin_date, checkout_date]
      # Date.strptime(checkin_date, '%Y-%m-%d')
      # Date.strptime(checkout_date, '%Y-%m-%d')
    end

end
