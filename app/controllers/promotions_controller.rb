class PromotionsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_promotion, only: [:show, :edit, :update, :destroy]

  # GET /promotions
  # GET /promotions.json
  def index
    if current_user && current_user.role == 1 #general user
      #should be changed to all promotions for venues near the user
      @promotions = Promotion.all
    elsif current_user && current_user.role == 2 #account_user - not currently used
      @userVenues = UserVenue.where(user_id: current_user.id).collect(&:venue_id)
      @promotions = Promotion.where(venue_id: @userVenues)
    elsif current_user && current_user.role == 3 #admin
      #get all promotions for all venues that the user is registered with
      @userVenues = UserVenue.where(user_id: current_user.id).collect(&:venue_id)
      @promotions = Promotion.where(venue_id: @userVenues)
    elsif current_user && current_user.role == 4
      @promotions = Promotion.all
    end
    render json: @promotions
  end

  # GET /promotions/1
  # GET /promotions/1.json
  def show
    render json: @promotion
  end

  # GET /promotions/new
  def new
    @promotion = Promotion.new
  end

  # GET /promotions/1/edit
  def edit
  end

  # POST /promotions
  # POST /promotions.json
  def create
    @promotion = Promotion.new(promotion_params)

    if @promotion.save
      render json: {promotion: @promotion, status: :created }
    else
      render json: {errors: @promotion.errors, status: :unprocessable_entity }
    end
  end

  # PATCH/PUT /promotions/1
  # PATCH/PUT /promotions/1.json
  def update
    @promotion = Promotion.find(promotion_params[:id])
    #authorize @promotion
    if @promotion.update(promotion_params)
      render json: { status: :ok, promotion: @promotion }
    else
      render json: { errors: @promotion.errors, status: :unprocessable_entity }
    end
  end

  # DELETE /promotions/1
  # DELETE /promotions/1.json
  def destroy
    if @promotion.destroy
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
                                        :venue_id, :description)
    end
end
