module HotelsHelper

  def hotel_guests(hotel, user)
    user.unbooked_reservation(hotel).guests
  end

  def hotel_beds(hotel, user)
    user.unbooked_reservation(hotel).room.beds 
  end

  def hotel_currency(hotel, user)
    user.unbooked_reservation(hotel).currency
  end
  
  def hotel_price(hotel, user)
    user.unbooked_reservation(hotel).price
  end

  def hotel_checkin(hotel, user)
    user.unbooked_reservation(hotel).checkin_date
  end

  def hotel_checkout(hote, userl)
    user.unbooked_reservation(hotel).checkout_date
  end

  def reservation_code(hotel, user)
    user.unbooked_reservation(hotel).code
  end

end
