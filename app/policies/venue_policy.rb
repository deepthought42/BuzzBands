class VenuePolicy < ApplicationPolicy
  class Scope < Scope

    def resolve
      if user.hypedrive_employee?
        scope.all
      elsif user.admin? || user.account_user?

        #get all venues for this current users accounts
        scope.where(account_id: user.account_id)

      else
        scope.all
        #scope.near([user.latitude, user.longitude], 1)
      end
    end
  end



  def create?
    @user.hypedrive_employee? || @user.admin?
  end

  def update?
    @user.admin? || @user.hypedrive_employee?
  end

  def destroy?
    @user.admin? || @user.hypedrive_employee?
  end

  def claimVenue?
    @user.admin?
  end

  def approveClaim?
    @user.hypedrive_employee?
  end
end
