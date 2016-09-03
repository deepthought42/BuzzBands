class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_user, only: [:show, :edit, :update, :destroy, :activate]

  after_action :verify_authorized, except: [:index, :show]
  after_action :verify_policy_scoped, only: :index

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  # GET /users
  # GET /users.json
  def index
    @users = policy_scope(User)
    render json: @users
  end

  # GET /users/1
  # GET /users/1.json
  def show
    render json: @user
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
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
    authorize @user
    if @user.update({active: false})
      render json: { status: :ok }
    else
      render json: { status: :unprocessable_entity}
    end
  end

  def activate
    authorize @user
    if @user.update({active: true})
      render json: { status: :ok }
    else
      render json: { status: :unprocessable_entity}
    end
  end

  #GET /admin/users/1/accounts.json
  def getAccounts
    authorize @user
    @accounts = @user.accounts
    render json: @accounts
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:id, :name, :nickname, :email, :role, :image, :active);
    end

    def user_not_authorized
      render json: {status: :unauthorized, message: "You are not authorized to perform this User action."}
    end
end
