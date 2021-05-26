module ReservationsHelper

  # For the current user, find the user's reservations for the given hotel, and order them from most recent to least recent checkin date
  # This method needs to be changed to ".find" instead of ".select" at a later point
#   def unbooked_reservation(current_user, hotel)
#     hotel.reservations.select { |reservation| reservation.id == nil && reservation.user_id = current_user.id}
#   end

#   # For the current user, find the user's reservations for the given hotel, and order them from most recent to least recent checkin date
#   def booked_reservations(current_user, hotel)
#     current_user.reservations.where("hotel_id = ?", hotel.id).order(checkin_date: :desc)
#   end

  def unbooked_reservation?(hotel)
    !User.first.unbooked_reservation(hotel).empty?
  end

  def upcoming_reservations?(hotel = nil)
    hotel ? !User.first.upcoming_reservations(hotel).empty? : !User.first.upcoming_reservations.empty?
  end

  def previous_reservations?(hotel = nil)
    hotel ? !User.first.previous_reservations(hotel).empty? : !User.first.previous_reservations.empty?
  end

  def upcoming_single_reservation?(reservation)
    reservation.checkin_date >= Date.today.to_s
  end

  def open_for_review?(reservation)
    reservation.checkout_date < Date.today.to_s
  end

  def full_info(reservations)
  end

end
