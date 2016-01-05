class PackageController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  # GET /promotions
  # GET /promotions.json
  def index
    @packages = Package.all
    render json: @packages
  end
end
