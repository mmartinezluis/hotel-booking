module HotelsHelper
  def hotel_price(hotel)
    hotel.reservations.last.price
  end

  def hotel_guests(hotel)
    hotel.reservations.last.guests
  end

  def hotel_beds(hotel)
    hotel.reservations.last.room.beds 
  end

  def hotel_checkin(hotel)
    hotel.reservations.last.checkin_date
  end

  def hotel_checkout(hotel)
    hotel.reservations.last.checkout_date
  end

  def reservation_code(hotel)
    hotel.reservations.last.code
  end

end
