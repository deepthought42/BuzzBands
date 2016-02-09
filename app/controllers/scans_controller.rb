class ScansControllerController < ApplicationController
  before_action :authenticate_user!, except: [:create]
  after_action :verify_policy_scoped, only: :index

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  # GET /scans
  # GET /scans.json
  def index
    @scans = policy_scope(Scan)
    render json: @scans
  end

  # POST /scans
  # POST /scans.json
  def create
    @scan = Scan.new(scan_params)
    if @scan.save
      render json: {status: :created, scan: @scan}
    else
      render json: { error: @scan.errors, status: :unprocessable_entity }
    end
  end

  private# Never trust parameters from the scary internet, only allow the white list through.
    def scan_params
      params.require(:scan).permit(:uuid, :venue_id)
    end

    def user_not_authorized
      render json: {status: :unauthorized, message: "You are not authorized to perform this action."}
    end
end
