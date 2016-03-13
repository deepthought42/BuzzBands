class AccountsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_account, only: [:show, :edit, :update, :destroy]
  after_action :verify_authorized, except: [:index]
  after_action :verify_policy_scoped, only: :index

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  # GET /accounts
  # GET /accounts.json
  def index
    @accounts = policy_scope(Account)

    render json: @accounts, include: [:user]
  end

  # GET /accounts/1
  # GET /accounts/1.json
  def show
    authorize @accounts
    render json: @account
  end

  # GET /accounts/new
  def new
    @account = Account.new
  end

  # POST /accounts
  # POST /accounts.json
  def create
    # Get the credit card details submitted by the form
    @token = account_params[:stripeToken]
    @amount = 500
    # Create a Customer
    customer = Stripe::Customer.create(
      :source => @token,
      :plan => account_params[:package_name],
      :email => current_user.email
    )

    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => @amount,
      :description => 'HypeDrive Stripe customer',
      :currency    => 'usd'
    )

    @account = Account.new
    authorize @account

    @account.stripe_customer_id = customer.id
    @account.user_id = current_user.id
    @account.package_id = 0;
    @account.users << current_user
    @account.active = TRUE

    if @account.save
      render json: {status: :created, account: @account}
    else
      render json: { error: @account.errors, status: :unprocessable_entity }
    end
  end

  def getPromotions
    @promotions = @account.promotions
    authorize @account
    render json: @promotions
  end

  #GET /accounts/1/users.json
  def getUsers
    authorize @account
    @users = @account.users

    render json: @users
  end

  # PATCH/PUT /accounts/1
  # PATCH/PUT /accounts/1.json
  def update
    authorize @account
    if @account.update(account_params)
      render json: { status: :ok, account: @account }
    else
      render json: {error: @account.errors, status: :unprocessable_entity }
    end
  end

  # Sets account active status to false.
  #  NB : System does not allow record deletion of accounts
  #
  # DELETE /accounts/1
  # DELETE /accounts/1.json
  def destroy
    authorize @account
    if @account.update({active: false})
      render json: { status: :ok }
    else
      render json: { status: :unprocessable_entity}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_account
      @account = Account.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def account_params
      params.require(:account).permit(:package_name, :stripeToken)
    end

    def user_not_authorized
      render json: {status: :unauthorized, message: "You are not authorized to access accounts."}
    end
end
