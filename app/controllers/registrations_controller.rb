class RegistrationsController < DeviseTokenAuth::RegistrationsController

  def create
    super
    if params[:venue_id]
      @venue = Venue.find(params[:venue_id])
      @user.venues.push(@venue)
    end
  end

  protected

  def sign_up_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :role, :venue, :provider, :venue_id)
  end

  def account_update_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :current_password, :role, :venue)
  end
end
