class PlacesController < ApplicationController
  before_action :fetch_place, only: %i[show edit update destroy]
  def index
    @categories = Place::CATEGORIES
    if params[:query].present?
      @places = Place.search_by_name_category_address_description(params[:query]).order(created_at: :desc)
    else
      @places = Place.all.order(created_at: :desc)
    end
      @markers = @places.geocoded.map do |flat|
      {
        lat: flat.latitude,
        lng: flat.longitude
      }
    end
  end

  def show
    @markers = [{ lat: @place.latitude, lng: @place.longitude }]
  end

  def new
    @place = Place.new
    @categories = Place::CATEGORIES
  end

  def create
    @place = Place.new(place_params)
    @place.user = current_user
    if @place.save
      redirect_to place_path(@place)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @place.update(place_params)
      @place.user = current_user
      redirect_to place_path(@place)
    else
      render :edit
    end
  end

  def destroy
    @place.destroy
    redirect_to places_path
  end

  private

  def fetch_place
    @place = Place.find(params[:id])
  end

  def place_params
    params.require(:place).permit(:name, :description, :address, :category, photos: [])
  end

end
