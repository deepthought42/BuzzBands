class VenuePolicy < ApplicationPolicy
  attr_reader :user, :venue

  def initialize(user, venue)
    @user = user
    @venue = venue
  end

  def create?
    @user.buzzbands_employee?
  end

  def update?
    @user.admin? || @user.buzzbands_employee?
  end

  def destroy?
    @user.admin? || @user.buzzbands_employee?
  end
end
