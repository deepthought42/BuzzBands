class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  after_action :verify_authorized, except: :index
  after_action :verify_policy_scoped, only: :index
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  # GET /orders
  # GET /orders.json
  def index
    @orders = policy_scope(Order)
    render json: @orders
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    authorize @order
    render json: @order
  end

  # GET /orders/new
  def new
    authorize @order
    @order = Order.new
  end

  # GET /orders/analytics/previousMonthBandOrders
  def previousMonthBandOrders
    @orders = Order.where("user_id = '?' AND created_at >= ? AND created_at <=?", current_user.id, Date.today.last_month.beginning_of_month, Date.today.beginning_of_month )
    authorize @orders

    render json: @orders
  end

  # POST /orders
  # POST /orders.json
  def create
    # Set your secret key: remember to change this to your live secret key in production
    # See your keys here https://dashboard.stripe.com/account/apikeys

    @order = Order.new(order_params)
    authorize @order

    # Create the charge on Stripe's servers - this will charge the user's card
    begin
      charge = Stripe::Charge.create(
        :amount => params[:price].to_i*100, # amount in cents, again
        :currency => "usd",
        :source => customer.id,
        :description => "Charge for #{current_user.uid}"
      )
    rescue Stripe::CardError => e
      @order.errors = e
    end

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
    authorize @order

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
    authorize @order

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
      params.require(:order).permit(:id, :venue_id, :user_id, :band_count, :color, :price, :status, :paymentToken)
    end

    def user_not_authorized
      render json: {status: :unauthorized, message: "You are not authorized to perform this action."}
    end
end
