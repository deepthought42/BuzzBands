class PromotionPolicy < ApplicationPolicy
  attr_reader :user, :promotion

  def initialize(user, promotion)
    @user = user
    @promotion = promotion
  end

  def update?
    @user.admin? || @user.hypedrive_employee?
  end

  def create?
    @user.admin? || @user.hypedrive_employee?
  end

  def destroy?
    @user.admin? || @user.hypedrive_employee?
  end

end
