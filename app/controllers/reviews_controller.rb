class ReviewsController < ApplicationController

  def index
    @reviews = User.first.all_reviews_sorted
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

  def edit
    @review = Review.find(params[:id])
  end

  def update
    @review = Review.find(params[:id])
    @review.save
    redirect_to review_path(@review)
  end

  private
  def review_params
    params.require(:review).permit(:description, :review_id)
  end

end
