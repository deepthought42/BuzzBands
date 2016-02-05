class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  after_action :verify_authorized, except: :index
  after_action :verify_policy_scoped, only: :index

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  # GET /users
  # GET /users.json
  def index
    @users = policy_scope(User)
    render json: @users
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    @user.active = FALSE
    authorize @user

    if @user.save
      render json: {status: :created, user: @user}
    else
      render json: { error: @user.errors, status: :unprocessable_entity }
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    @user = User.find(user_params[:id])
    authorize @user
    if @user.update(user_params)
      render json: { status: :ok, user: @user }
    else
      render json: { errors: @user.errors, status: :unprocessable_entity }
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    authorize @user
    if @user.destroy
      render json: { status: :ok }
    else
      render json: { status: :unprocessable_entity}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:id, :name, :nickname, :email, :uid, :role, :image, :confirm_success_url, :confirm_name, :registration, :session);
    end

    def user_not_authorized
      render json: {status: :unauthorized, message: "You are not authorized to perform this action."}
    end
end
