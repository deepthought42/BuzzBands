class VenuesController < ApplicationController
  before_action :authenticate_user!, except: [ :getNearestVenues, :show, :getPromotions]
  before_action :set_venue, only: [:show, :edit, :update, :destroy, :getPromotions]
  after_action :verify_authorized, except: [:index, :show, :getPromotions, :getNearestVenues]
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  # Returns the list of venues based on the user's role.
  # Roles:
  # =>  User: See all venues within 2 miles of user
  # =>  account user: see all venues associated with the account
  # =>  admin:    see all venues that are associated with the account
  # =>  hypedrive employee: see all venues
  #
  # GET /venues
  # GET /venues.json
  def index
    #@venues = policy_scope(Venue)

    if current_user
      @user = User.find(current_user.id)
      #logger.info @user.accounts
    end

    if current_user && @user.role == 'account_user' #account_user - not currently used
      @venues = Venue.where(account_id: current_user.account_id)
    elsif current_user && @user.role == "admin" #admin
      #get all promotions for all venues that the current account is registered with
      @venues = Venue.where(account_id: current_user.account_id)
    elsif current_user && @user.role == "hypedrive_employee"
      @venues = Venue.all
    else
      if(params[:lat] && params[:lng])
        @venues = Venue.near([params[:lat], params[:lng]], 1)
      else
        @venues = Venue.all
      end
    end

    @venues.each { |venue|
      venue.promo_count = venue.promotions.count
      #venue.distance = Venue.distance_to("#{current_user.latitude}, #{current_user.longitude}")
    }

    #get count of active promotions available for a user
    render json: @venues
  end

  def getNearestVenues
    if(params[:lat] && params[:lng])
      @venues = Venue.near([params[:lat], params[:lng]], 100)
    else
      @venues = Venue.all
    end

    @venues.each { |venue|
      venue.promo_count = venue.promotions.count
      #venue.distance = Venue.distance_to("#{current_user.latitude}, #{current_user.longitude}")
    }

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

  # Creates a venue with a couple caveats
  # => if the user submitting the request is a hypedrive employee then we set
  #       the venue active and assign the desired account
  # => if the user submitting the requiest is an admin then we set the venue
  #       inactive and assing the account based on the account owned by the
  #       current user
  # POST /venues
  # POST /venues.json
  def create
    @venue = Venue.new(venue_params)
    authorize @venue

    if(current_user.role == 3)
      @venue.active = TRUE
      @venue.account_id = account_id
    else
      @venue.active = FALSE
      @account = Account.where(user_id: current_user.id).first
      @venue.account = @account
    end

    if @venue.save
      render json: {status: :created, venue: @venue}
    else
      render json: { error: @venue.errors, status: :unprocessable_entity }
    end
  end

  def getPromotions
    @promotions = @venue.promotions.where('start_time >= :time_now or end_time >= :time_now',
                                  :time_now  => Time.now)
    render json: @promotions
  end

  # PATCH/PUT /venues/1
  # PATCH/PUT /venues/1.json
  def update
    authorize @venue
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


  def approveClaim
    authorize @venue

    if @venue.update({active: true})
      render json: { status: :ok }
    else
      render json: { status: :unprocessable_entity}
    end
  end


  def claimVenue
    authorize @venue
    if !@venue.account_id
      @account = Accouts.where(user_id: current_user.id).first()
      @venue.account = @account

      if @venue.update({active: true})
        render json: { status: :ok }
      else
        render json: { status: :unprocessable_entity}
      end
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
      params.require(:venue).permit(:name, :address, :city, :state, :zip_code,
                                    :url, :user, :category, :account_id,
                                    :lat, :lng, :capacity, :cover)
    end

    def user_not_authorized
      render json: {status: :unauthorized, message: "You are not authorized to perform this action."}
    end
end
