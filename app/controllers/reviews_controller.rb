class ReviewsController < ApplicationController
  before_action :fetch_place
  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @review.user = current_user
    @review.place = @place
    if @review.save
      redirect_to place_path(@place)
    else
      render :new
    end
  end

  private

  def fetch_place
    @place = Place.find(params[:place_id])
  end

  def review_params
    params.require(:review).permit(:title, :description, :rating)
  end
end
