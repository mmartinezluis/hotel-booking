class ReservationsController < ApplicationController

  def index
    @reservations = User.first.all_reservations
  end
  
end
