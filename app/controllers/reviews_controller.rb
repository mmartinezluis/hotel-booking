class ReviewsController < ApplicationController

  def new

    @review = Review.new(reservation_id: params[:reservation_id])
  end
end
