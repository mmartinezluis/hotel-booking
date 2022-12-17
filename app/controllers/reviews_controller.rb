class ReviewsController < ApplicationController
  # before_action :check_reservation_id, :check_review_id, only: [:new, :show, :edit]
  before_action :check_reservation_id, only: [:new, :show]
  before_action :check_review_id, only: [:show, :edit, :update]

  def index
    @reviews = current_user.all_reviews_sorted
  end

  def new
    if @reservation && @reservation.checkout_date >= Date.today.to_s
      flash[:msg] = "Reservations open for review one day after the reservation's checkout date"
      redirect_to reservations_path
    else
      #  If the new review is requested from the nested new_reservation_review path, catch the nested reservation's id
      @review = Review.new(reservation_id: params[:reservation_id])
    end
  end

  def create
    @review = Review.new(review_params)
    if @review.save
      flash[:msg] = "Review succesfully created"
      redirect_to review_path(@review)
    else
      render :new
    end
  end

  def show
    
  end

  def edit
    
  end

  def update
    if @review.update(review_params)
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
    @reservation = nil
    if params[:reservation_id] 
      @reservation = current_user.reservations.find_by(id: params[:reservation_id])
      if !@reservation
        flash[:msg] = "Reservation not found"
        redirect_to reservations_path and return
      end
    end
    @reservation
  end

  def check_review_id
    @review = current_user.reviews.find_by(id: params[:id])
    if !@review
      flash[:msg] = "Review not found"
      redirect_to reviews_path and return
    end
    @review
  end

end
