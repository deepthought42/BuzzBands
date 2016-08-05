class VenuePolicy < ApplicationPolicy
  attr_reader :user, :venue

  def initialize(user, venue)
    @user = user
    @venue = venue
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

  def getAccounts?
    @user.hypedrive_employee?
  end
end
