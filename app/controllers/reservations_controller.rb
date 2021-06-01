class ReservationsController < ApplicationController

  def index
    @reservations = User.first.all_reservations
  end

  def show
    if !User.first.reservations.exists?(params[:id])
      flash[:msg] = "Reservation not found"
      redirect_to reservations_path 
    else
      @single_reservation = User.first.reservations.find_by(id: params[:id]) 
      @hotel = @single_reservation.hotel
      render :'hotels/show.html.erb' 
    end
  end

end
