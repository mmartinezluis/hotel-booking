module ReviewsHelper

  def ready_for_review
  end

  def reservation_id_field(review)
    if review.reservation.nil?
      if User.first.open_for_review_reservations
        select_tag "review[reservation_id", options_from_collection_for_select(User.first.open_for_review_reservations, :id, :hotel_and_checkin)
      else
        "You don't currently have open for review reservations"
      end
    else
      hidden_field_tag "review[reservation_id]", review.reservation_id
    end
  end
  
end
