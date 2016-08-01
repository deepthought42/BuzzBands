class PackagesController < ApplicationController
  include Pundit
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_package, only: [:show, :update, :destroy]
  after_action :verify_authorized, except: [:index, :show]
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  # GET /packages
  # GET /packages.json
  def index
    @packages = Package.all
    render json: @packages
  end

  # GET /packages/1
  # GET /packages/1.json
  def show
    render json: @package
  end

  # POST /packages
  # POST /packages.json
  def create
    @package = Package.new(package_params)
    authorize @package

    if @package.save
      render json: {status: :created, package: @package}
    else
      render json: { error: @package.errors, status: :unprocessable_entity }
    end
  end

  # PATCH/PUT /packages/1
  # PATCH/PUT /packages/1.json
  def update
    authorize @package
    if @package.update(package_params)
      render json: { status: :ok, package: @package }
    else
      render json: {error: @package.errors, status: :unprocessable_entity }
    end
  end

  # Sets package active status to false.
  #  NB : System does not allow record deletion of packages
  #
  # DELETE /packages/1
  # DELETE /packages/1.json
  def destroy
    authorize @package
    if @package.update({active: false})
      render json: { status: :ok }
    else
      render json: { status: :unprocessable_entity}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_package
      @package = Package.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def package_params
      params.require(:package).permit(:name, :venue_count, :promotion_count, :band_fee, :price)
    end

    def user_not_authorized
      render json: {status: :unauthorized, message: "You are not authorized to perform this action."}
    end
end
