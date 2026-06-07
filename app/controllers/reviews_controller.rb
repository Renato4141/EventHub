class ReviewsController < ApplicationController
  before_action :set_review, only: [:show, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @reviews = Review.includes(:user, :event).all
  end

  def show
    authorize @review
  end

  def create
    @event = Event.find(params[:review][:event_id])
    @review = Review.new(review_params)
    @review.user = current_user
    @review.event = @event
    authorize @review

    if @review.save
      redirect_to @event, notice: "Review submitted successfully."
    else
      redirect_to @event, alert: @review.errors.full_messages.join(", ")
    end
  end

  def destroy
    authorize @review
    @event = @review.event
    @review.destroy
    redirect_to @event, notice: "Review deleted."
  end

  private

  def set_review
    @review = Review.find(params[:id])
  end

  def review_params
    params.require(:review).permit(:rating, :comment, :event_id)
  end
end