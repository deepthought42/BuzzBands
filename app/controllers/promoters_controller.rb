class PromotersController < ApplicationController
  before_action :set_promoter, only: [:show, :update, :destroy]

  # GET /promoters
  # GET /promoters.json
  def index
    @promoters = Promoter.all

    render json: @promoters
  end

  # GET /promoters/1
  # GET /promoters/1.json
  def show
    render json: @promoter
  end

  # POST /promoters
  # POST /promoters.json
  def create
    @promoter = Promoter.new(promoter_params)

    if @promoter.save
      render json: @promoter, status: :created, location: @promoter
    else
      render json: @promoter.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /promoters/1
  # PATCH/PUT /promoters/1.json
  def update
    @promoter = Promoter.find(params[:id])

    if @promoter.update(promoter_params)
      head :no_content
    else
      render json: @promoter.errors, status: :unprocessable_entity
    end
  end

  # DELETE /promoters/1
  # DELETE /promoters/1.json
  def destroy
    @promoter.destroy

    head :no_content
  end

  private

    def set_promoter
      @promoter = Promoter.find(params[:id])
    end

    def promoter_params
      params.require(:promoter).permit(:name)
    end
end
