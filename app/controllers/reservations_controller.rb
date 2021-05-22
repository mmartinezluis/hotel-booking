class ReservationsController < ApplicationController

  def index
    @reservations = User.first.reservations
  end
  
end
