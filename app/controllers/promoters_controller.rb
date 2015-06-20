class PromotersController < ApplicationController
  before_action :set_promoter, only: [:show, :edit, :update, :destroy]

  # GET /promoters
  # GET /promoters.json
  def index
    @promoters = Promoter.all
  end

  # GET /promoters/1
  # GET /promoters/1.json
  def show
  end

  # GET /promoters/new
  def new
    @promoter = Promoter.new
  end

  # GET /promoters/1/edit
  def edit
  end

  # POST /promoters
  # POST /promoters.json
  def create
    @promoter = Promoter.new(promoter_params)

    respond_to do |format|
      if @promoter.save
        format.html { redirect_to @promoter, notice: 'Promoter was successfully created.' }
        format.json { render :show, status: :created, location: @promoter }
      else
        format.html { render :new }
        format.json { render json: @promoter.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /promoters/1
  # PATCH/PUT /promoters/1.json
  def update
    respond_to do |format|
      if @promoter.update(promoter_params)
        format.html { redirect_to @promoter, notice: 'Promoter was successfully updated.' }
        format.json { render :show, status: :ok, location: @promoter }
      else
        format.html { render :edit }
        format.json { render json: @promoter.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /promoters/1
  # DELETE /promoters/1.json
  def destroy
    @promoter.destroy
    respond_to do |format|
      format.html { redirect_to promoters_url, notice: 'Promoter was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_promoter
      @promoter = Promoter.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def promoter_params
      params.require(:promoter).permit(:name)
    end
end
