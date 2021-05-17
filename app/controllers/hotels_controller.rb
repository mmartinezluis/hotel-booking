class HotelsController < ApplicationController
    # before_action :set_api, set_hotel on reserve
  def index
    if AmadeusApi.all.first
      api = AmadeusApi.all.first
    else
      api = AmadeusApi.new
    end
    if params[:query] && !params[:query].blank?
      @hotels = api.query_city(params[:query])
      if @hotels.emtpy?
        flash[:msg] = "Ooops, no hotels could be found for the requsted specifications"
      end
    end
  end

  def show
    api = AmadeusApi.all.first
    @hotel = api.hotels.select { |hotel| hotel.hotelId == params[:hotelId] }
  end

  def reserve
    api = AmadeusApi.all.first
    @hotel = api.hotels.select { |hotel| hotel.hotelId == parasm[:id] }
    reservation = api.amadeus.shopping.hotel_offer(params[:code]).get.data
    if reservation
        reservation["available"]  == true
        reservation["offers"]["checkInDate"] == @hotel.reservations.first.checkin_date
        reservation["offers"]["checkOutDate"] == @hotel.reservations.first.checkout_date
        reservation["offers"][0]["guests"]["adults"] == @hotel.reservations.first.guests
        reservation["offers"][0]["price"]["total"] == @hotel.reservations.first.price
        @hotel.save
        api.hotels.clear
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
