module ReservationsHelper

  def unbooked_reservation?(user, hotel)
    !user.unbooked_reservation(hotel).nil?
  end

  def upcoming_reservations?(user, hotel = nil)
    hotel ? !user.upcoming_reservations(hotel).empty? : !user.upcoming_reservations.empty?
  end

  def previous_reservations?(user, hotel = nil)
    hotel ? !user.previous_reservations(hotel).empty? : !user.previous_reservations.empty?
  end

  def upcoming_single_reservation?(reservation)
    reservation.checkin_date >= Date.today.to_s
  end

  def open_for_review?(reservation)
    reservation.checkout_date < Date.today.to_s
  end

end
