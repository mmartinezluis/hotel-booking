class HotelsController < ApplicationController
#   before_action :set_api 
#   before_action :set_hotel, only: [:show, :reserve]

  def index
    api = AmadeusApi.all.last
    api ||= AmadeusApi.new
    AmadeusApi.hotels.clear
    if params[:city] && !params[:city].blank?
      begin
        if params[:checkin_date].blank? && params[:checkout_date].blank? && params[:guests].blank?
          @hotels = api.query_city(params[:city])
        else
          @hotels = api.query_city(params[:city], params[:checkin_date], params[:checkout_date], params[:guests])
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

  def show
    # api = AmadeusApi.new
    @hotel = AmadeusApi.hotels.find { |hotel| hotel.hotelId == params[:hotelId] }
  end

  def reserve
    api = AmadeusApi.all.last
    @hotel = AmadeusApi.hotels.find { |hotel| hotel.hotelId == params[:hotelId] }
    begin
      reservation = api.amadeus.shopping.hotel_offer(params[:code]).get.data 
    rescue StandardError => e
      flash[:msg] = "#{e.class}: #{e.message}. Please try again..."
      redirect_to root_path
    else 
      if reservation && reservation["available"]  == true
        checkin = reservation["offers"][0]["checkInDate"] == @hotel.last_reservation.checkin_date
        checkout = reservation["offers"][0]["checkOutDate"] == @hotel.last_reservation.checkout_date
        guests = reservation["offers"][0]["guests"]["adults"] == @hotel.last_reservation.guests
        # price = reservation["offers"][0]["price"]["total"] == @hotel.last_reservation.price
        if checkin && checkout && guests #&& price
          AmadeusApi.hotels.clear
          @hotel.save
          flash[:msg] = "Congratualtions! Your reservation was successfully processed."
          redirect_to root_path
        else
          flash[:msg]= "Sorry, one or more of the reservation conditions have changed. Please retry you hotel search."
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
#   end

#   def set_hotel
#     @hotel = api.hotels.find { |hotel| hotel.hotelId == params[:hotelId] }
#   end
end
