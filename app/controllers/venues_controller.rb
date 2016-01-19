class VenuesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :getPromotions]
  before_action :set_venue, only: [:show, :edit, :update, :destroy, :getPromotions]

  # GET /venues
  # GET /venues.json
  def index
    logger.debug "Role for user : #{current_user.role}"
    if current_user && current_user.role == 'user' #general user
      #should be changed to all promotions for venues near the user
      @venues = Venue.all
    elsif current_user && current_user.role == 'account_user' #account_user - not currently used
      @userVenues = UserVenue.where(user_id: current_user.id).collect(&:venue_id)
      @venues = Venue.find(@userVenues)
    elsif current_user && current_user.role == "admin" #admin
      #get all promotions for all venues that the user is registered with
      @userVenues = UserVenue.where(user_id: current_user.id).collect(&:venue_id)
      @venues = Venue.find(@userVenues)
    elsif current_user && current_user.role == "buzzbands_employee"
      @venues = Venue.all
    end
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

  #GET /venues/1/users.json
  def getUsers
    @users = @venue.users
    render json: @users
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

  # Sets venue active status to false.
  #  NB : System does not allow record deletion of venues
  #
  # DELETE /venues/1
  # DELETE /venues/1.json
  def destroy
    if @venue.update({active: false})
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
      params.require(:venue).permit(:name, :address, :city, :state, :zip_code, :url, :active, :user, :category)
    end
end
