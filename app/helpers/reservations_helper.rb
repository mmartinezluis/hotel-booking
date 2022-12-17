module ReservationsHelper

  def upcoming_single_reservation?(reservation)
    reservation.checkin_date >= Date.today.to_s
  end

  def open_for_review?(reservation)
    reservation.checkout_date < Date.today.to_s
  end

end
