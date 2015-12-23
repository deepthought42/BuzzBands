class RegistrationsController < Devise::RegistrationsController
  def create
    @venue = Venue.find(params[:venue_id])
    logger.info "VENUES FOR USER :: #{@venue.name}"

    super
    @userVenue = UserVenue.new()
    @userVenue.venue_id = params[:venue_id]
    @userVenue.role = params[:role]
    @user.user_venues.push(@userVenue)
    @user.user_venues.first.role = params[:role]

    logger.info "VENUES FOR USER :: #{@userVenue.role}"


  end

  protected

  def sign_up_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :role, :venue, :uid, :provider, :venue_id)
  end

  def account_update_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :current_password, :role, :venue)
  end
end
