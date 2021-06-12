class ReservationsController < ApplicationController

  def index
    @reservations = current_user.all_reservations
  end

  #  The show action uses the hotels/show template; reservations don't have their own show page
  def show
    if !current_user.reservations.exists?(params[:id])
      flash[:msg] = "Reservation not found"
      redirect_to reservations_path 
    else
      @single_reservation = current_user.reservations.find_by(id: params[:id]) 
      @hotel = @single_reservation.hotel
      render :'hotels/show.html.erb' 
    end
  end

end
