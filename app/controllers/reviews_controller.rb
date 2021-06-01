class ReviewsController < ApplicationController
  before_action :check_reservation_id, :check_review_id, only: [:new, :show, :edit]
  before_action :check_review_id, only: [:show, :edit]

  def index
    @reviews = User.first.all_reviews_sorted
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
    @review.save
    redirect_to review_path(@review)
  end

  private
  def review_params
    params.require(:review).permit(:description, :reservation_id)
  end

  def check_reservation_id
    if params[:reservation_id] && !User.first.reservations.exists?(params[:reservation_id])
      flash[:msg] = "Reservation not found"
      redirect_to reservations_path and return
    end
  end

  def check_review_id
    if !User.first.reviews.exists?(params[:id])
      flash[:msg] = "Review not found"
      redirect_to reviews_path and return
    end
  end

end
