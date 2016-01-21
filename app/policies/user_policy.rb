class UserPolicy < ApplicationPolicy
  attr_reader :current_user, user_1

  def initialize(current_user, user_1)
    @user = current_user
    @user_1 = user_1
  end

  def index?
    @user.admin? || @user.buzzbands_employee?
  end

  def update?
    @user.admin? || @user.buzzbands_employee?
  end

  def create?
    @user.admin? || @user.buzzbands_employee?
  end

  def destroy?
    @user.admin? || @user.buzzbands_employee?
  end
end
