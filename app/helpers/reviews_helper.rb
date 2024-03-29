module ReviewsHelper

  def reservation_id_field(review, user)
    # if the new review does not have a reservation, provide a select field to choose a reservation for the review
    if review.reservation.nil?
      select_tag "review[reservation_id]", options_from_collection_for_select(user.open_for_review_reservations, :id, :hotel_and_checkin, :include_blank => true)
    else
      hidden_field_tag "review[reservation_id]", review.reservation_id
    end
  end
  
end
