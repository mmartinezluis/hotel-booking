class ReviewsController < ApplicationController

  def index
    @reviews= Review.joins(:reservations).where("user_id = ?", User.first.id)
  end

  def new
    @review = Review.new(reservation_id: params[:reservation_id])
  end

  def create
    review = Review.create(params.require(:review).permit(:description, :reservation_id))
    redirect_to review_path(review)
  end

  def show
    @review = Review.find(params[:id])
  end




end
