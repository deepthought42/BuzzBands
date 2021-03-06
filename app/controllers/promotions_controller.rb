class PromotionsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_promotion, only: [:show, :edit, :update, :destroy]
  after_action :verify_authorized, except: [:index, :show]

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  # GET /promotions
  # GET /promotions.json
  def index
    if current_user
      @user = User.find(current_user.id)
    end

    if current_user && @user.role == "account_user" #account_user - not currently used
      @venues = Venue.where(account_id: current_user.account_id)
      @promotions = Promotion.where(venue_id: @venues)
    elsif current_user && @user.role == "admin" #admin
      #get all promotions for all venues that the user is registered with
      @venues = Venue.where(account_id: current_user.account_id)
      @promotions = Promotion.where(venue_id: @venues)
    elsif current_user && @user.role == "hypedrive_employee"
      @promotions = Promotion.all
    else
      @promotions = Promotion.where('active=:isActive and (start_time >= :time_now or end_time >= :time_now)',
                                    :isActive => true,
                                    :time_now  => Time.now)
    end
    render json: @promotions
  end

  # GET /promotions/1
  # GET /promotions/1.json
  def show
    render json: @promotion
  end

  # POST /promotions
  # POST /promotions.json
  def create
    @promotion = Promotion.new(promotion_params)
    authorize @promotion
    if @promotion.save
      render json: {promotion: @promotion, status: :created }
    else
      render json: {errors: @promotion.errors, status: :unprocessable_entity }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /promotions/1
  # PATCH/PUT /promotions/1.json
  def update
    @promotion = Promotion.find(promotion_params[:id])
    authorize @promotion
    if @promotion.update(promotion_params)
      render json: { status: :ok, promotion: @promotion }
    else
      render json: { errors: @promotion.errors, status: :unprocessable_entity }
    end
  end

  # DELETE /promotions/1
  # DELETE /promotions/1.json
  def destroy
    authorize @promotion

    if @promotion.update({active: false})
      render json: { status: :ok }
    else
      render json: { status: :unprocessable_entity}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_promotion
      @promotion = Promotion.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def promotion_params
      params.require(:promotion).permit(:id, :name, :ad_location,
                                        :start_time, :end_time, :active,
                                        :venue_id, :description, :notes, :rating)
    end

    def user_not_authorized
      render json: {status: :unauthorized, message: "You are not authorized to perform this action."}
    end
end
