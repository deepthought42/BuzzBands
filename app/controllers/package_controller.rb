class PackageController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  # GET /promotions
  # GET /promotions.json
  def index
    @packages = [{
      id: 0,
      count: 250,
      price: '25.00'
    },{
      id: 1,
      count: 500,
      price: '50.00'
    },{
      id: 2,
      count: 750,
      price: '75.00'
    },{
      id: 3,
      count: 1000,
      price: '100.00'
    },{
      id: 4,
      count: 10000,
      price: '1000.00'
    }]
    render json: @packages
  end
end
