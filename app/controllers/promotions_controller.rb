class PromotionsController < ApplicationController
  before_action :set_promotion, only: [:show, :edit, :update, :destroy]

  # GET /promotions
  # GET /promotions.json
  def index
    @promotions = Promotion.all
    render json: @promotions
  end

  # GET /promotions/1
  # GET /promotions/1.json
  def show
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
      render json: { status: :created, @promotion }
    else
      render json: { @promotion.errors, status: :unprocessable_entity }
    end
  end

  # PATCH/PUT /promotions/1
  # PATCH/PUT /promotions/1.json
  def update
    if @promotion.update(promotion_params)
      render json: { status: :ok, @promotion }
    else
      render json: { @promotion.errors, status: :unprocessable_entity }
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
      params.require(:promotion).permit(:name, :ad_location, :start_time, :end_time)
    end
end
