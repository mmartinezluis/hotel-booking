class ReservationsController < ApplicationController

  def index
    @reservations = current_user.reservations.any?
  end

  #  The show action uses the hotels/show template; reservations don't have their own show page
  def show
    @single_reservation = current_user.reservations.find_by(id: params[:id]) 
    if @single_reservation
      @hotel = @single_reservation.hotel
      render :'hotels/show.html.erb' 
    else 
      flash[:msg] = "Reservation not found"
      redirect_to reservations_path 
    end
  end

end
