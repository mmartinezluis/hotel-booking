class ReviewsController < ApplicationController
  before_action :check_reservation_id, :check_review_id, only: [:new, :show, :edit]
  before_action :check_review_id, only: [:show, :edit]

  def index
    @reviews = current_user.all_reviews_sorted
  end

  def new
    @review = Review.new(reservation_id: params[:reservation_id])
  end

  def create
    review = Review.create(review_params)
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
    @review.update(review_params)
    redirect_to review_path(@review)
  end

  def destroy
    review = Review.find_by(id: params[:id])
    review.destroy
    flash = "Review successfully deleted"
    redirect_to reviews_path
  end

  private
  def review_params
    params.require(:review).permit(:description, :reservation_id)
  end

  def check_reservation_id
    if params[:reservation_id] && !current_user.reservations.exists?(params[:reservation_id])
      flash[:msg] = "Reservation not found"
      redirect_to reservations_path and return
    end
  end

  def check_review_id
    if !current_user.reviews.exists?(params[:id])
      flash[:msg] = "Review not found"
      redirect_to reviews_path and return
    end
  end

end
