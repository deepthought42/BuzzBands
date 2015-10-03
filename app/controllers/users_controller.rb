class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:roles]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
    render json: @users
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
    if @user.destroy
      render json: { status: :ok }
    else
      render json: { status: :unprocessable_entity}
    end
  end

  # GET /users/:id/roles
  # GET /users/:id/roles.json
  def roles
    @user = User.find(params[:id])
    render json: @user.roles
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :nickname, :email, :uid);
    end
end
