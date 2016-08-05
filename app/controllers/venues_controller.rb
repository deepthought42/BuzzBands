class VenuesController < ApplicationController
  before_action :authenticate_user!, except: [:show, :getPromotions]
  before_action :set_venue, only: [:show, :edit, :update, :destroy, :getPromotions]
  after_action :verify_authorized, except: [ :index, :show, :getPromotions]
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  # Returns the list of venues based on the user's role.
  # Roles:
  # =>  User: See all venues
  # =>  account user: see all venues associated with the account
  # =>  admin:    see all venues that are associated with the account
  # =>  hypedrive employee: see all venues
  #
  # GET /venues
  # GET /venues.json
  def index
    if current_user
      @user = User.find(current_user.id)
      @accounts = AccountsUsers.where(user_id: current_user.id).collect(&:account_id)
      logger.info @accounts
    end

    if current_user && @user.role == 'account_user' #account_user - not currently used
      @venues = Venue.where(account_id: @accounts)
    elsif current_user && @user.role == "admin" #admin
      #get all promotions for all venues that the current account is registered with
      @venues = Venue.where(account_id: @accounts)
    elsif current_user && @user.role == "hypedrive_employee"
      @venues = Venue.all
    else
      #should be changed to all promotions for venues near the user
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

  # POST /venues
  # POST /venues.json
  def create
    @venue = Venue.new(venue_params)
    authorize @venue
    @account = Account.where(user_id: current_user.id).first
    @venue.active = FALSE
    @venue.account = @account

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

  #GET /venues/1/accounts.json
  def getAccounts
    authorize @venue
    @accounts = @venue.accounts
    render json: @accounts
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_venue
      @venue = Venue.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def venue_params
      params.require(:venue).permit(:name, :address, :city, :state, :zip_code, :url, :active, :user, :category)
    end

    def user_not_authorized
      render json: {status: :unauthorized, message: "You are not authorized to perform this action."}
    end
end
