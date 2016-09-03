class UserPolicy < ApplicationPolicy
  attr_reader :user

  def initialize( user )
    @user = user
  end

  def index?
    current_user #truthy if logged in, nil otherwise
  end

  def activate?
    @user.hypedrive_employee?
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
