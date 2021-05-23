class ReservationsController < ApplicationController

  def index
    @reservations = User.first.all_reservations
  end

  def show
    reservation = User.first.reservations.find_by(id: params[:id]) 
    @hotel = [reservation.hotel]
    render :'hotels/show.html.erb'
  end
end
