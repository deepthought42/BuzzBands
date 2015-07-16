class PromotionPolicy < ApplicationPolicy
  attr_reader :user, :promotion

  def initialize(user, promotion)
    @user = user
    @promotion = promotion
  end

  def update?
    user.admin?
  end
end