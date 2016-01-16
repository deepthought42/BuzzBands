class OrdersController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all
    render json: @orders
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    render json: @order
  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)

    if @order.save
      render json: {order: @order, status: :created }
    else
      render json: {errors: @order.errors, status: :unprocessable_entity }
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    @order = Order.find(order_params[:id])
    #authorize @order
    if @order.update(order_params)
      render json: { status: :ok, order: @order }
    else
      render json: { errors: @order.errors, status: :unprocessable_entity }
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    if @order.destroy
      render json: { status: :ok }
    else
      render json: { status: :unprocessable_entity}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:id, :venue_id, :user_id, :band_count, :price, :status)
    end
end
