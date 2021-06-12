class ReviewsController < ApplicationController
  before_action :check_reservation_id, :check_review_id, only: [:new, :show, :edit]
  before_action :check_review_id, only: [:show, :edit]

  def index
    @reviews = current_user.all_reviews_sorted
  end

  def new
    #  I the new review is requested from the nested reservation_review route, catch the nested reservation's id
    @review = Review.new(reservation_id: params[:reservation_id])
  end

  def create
    @review = Review.new(review_params)
    if @review.valid?
      @review.save
      flash[:msg] = "Review succesfully created"
      redirect_to review_path(@review)
    else
      render :new
    end
  end

  def show
    @review = Review.find(params[:id])
  end

  def edit
    @review = Review.find(params[:id])
  end

  def update
    @review = Review.find(params[:id])
    if @review.update(review_params)
      @review.update(review_params)
      flash[:msg] = "Review succesfully updated"
      redirect_to review_path(@review)
    else
      render :edit
    end
  end

  def destroy
    review = Review.find_by(id: params[:id])
    review.destroy
    flash[:msg] = "Review successfully deleted"
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
