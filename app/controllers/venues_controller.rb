class VenuesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :getPromotions]
  before_action :set_venue, only: [:show, :edit, :update, :destroy, :getPromotions]

  # GET /venues
  # GET /venues.json
  def index
    @venues = Venue.all
    render json: @venues
  end

  # GET /venues/1
  # GET /venues/1.json
  def show
    render json: @venue
  end

  # GET /venues/new
  def new
    @venue = Venue.new
  end

  # GET /venues/1/edit
  def edit
  end

  # POST /venues
  # POST /venues.json
  def create
    @venue = Venue.new(venue_params)
    @venue.active = FALSE
    if @venue.save
      render json: {status: :created, venue: @venue}
    else
      render json: { error: @venue.errors, status: :unprocessable_entity }
    end
  end

  def getPromotions
    @promotions = @venue.promotions
    render json: @promotions
  end

  # PATCH/PUT /venues/1
  # PATCH/PUT /venues/1.json
  def update
    if @venue.update(venue_params)
      render json: { status: :ok, venue: @venue }
    else
      render json: {error: @venue.errors, status: :unprocessable_entity }
    end
  end

  # DELETE /venues/1
  # DELETE /venues/1.json
  def destroy
    if @venue.destroy
      render json: { status: :ok }
    else
      render json: { status: :unprocessable_entity}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_venue
      @venue = Venue.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def venue_params
      params.require(:venue).permit(:name, :address, :city, :state, :zip_code, :url, :active)
    end
end
