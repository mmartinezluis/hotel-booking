module ReviewsHelper

  def reservation_id_field(review, user)
    if review.reservation.nil?
      select_tag "review[reservation_id", options_from_collection_for_select(user.open_for_review_reservations, :id, :hotel_and_checkin)
    else
      hidden_field_tag "review[reservation_id]", review.reservation_id
    end
  end
  
end
