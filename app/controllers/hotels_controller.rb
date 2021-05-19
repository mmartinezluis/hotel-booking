class HotelsController < ApplicationController
    # before_action :set_api, set_hotel on reserve
  def index
    if AmadeusApi.all.first
      api = AmadeusApi.all.first
    else
      api = AmadeusApi.new
    end
    api.hotels.clear
    if params[:query] && !params[:query].blank?
      @hotels = api.query_city(params[:query])
      if @hotels.empty?
        flash[:msg] = "Ooops, no hotels could be found for the requsted specifications"
      end
    end
  end

  def show
    api = AmadeusApi.all.first
    @hotel = api.hotels.find { |hotel| hotel.hotelId == params[:hotelId] }
  end

  def reserve
    api = AmadeusApi.new
    @hotel = api.hotels.find { |hotel| hotel.hotelId == params[:hotelId] }
    begin
      reservation = api.amadeus.shopping.hotel_offer(params[:code]).get.data 
    rescue StandardError => e
      flash[:msg] = "#{e.class}: #{e.message}. Please try again..."
      # flash[:msg] = "The reservation could not processed as it has already been booked. Please try another reservation."
      redirect_to root_path
    else
      if reservation
        reservation["available"]  == true
        reservation["offers"][0]["checkInDate"] == @hotel.reservations.last.checkin_date
        reservation["offers"][0]["checkOutDate"] == @hotel.reservations.last.checkout_date
        reservation["offers"][0]["guests"]["adults"] == @hotel.reservations.last.guests
        reservation["offers"][0]["price"]["total"] == @hotel.reservations.last.price
        @hotel.save
        api.hotels.clear
        flash[:msg] = "Congratualtions! Your reservation was successfully processed."
      end
      redirect_to root_path
    end
    
  end

  private
#   def set_api
#     if AmadeusApi.all.first
#       api = AmadeusApi.all.first
#     else
#       api = AmadeusApi.new
#     end
#   end

#   def set_hotel
#     @hotel = api.hotels.select { |hotel| hotel.hotelId == params[:hotelId] }
#   end
end
