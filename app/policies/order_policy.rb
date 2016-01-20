class OrderPolicy < ApplicationPolicy
  attr_reader :user, :order

  def initialize(user, order)
    @user = user
    @order = order
  end

  def show?
    @user.admin? || @user.buzzbands_employee?
  end

  def new?
    @user.admin? || @user.buzzbands_employee?
  end

  def create?
    @user.admin? || @user.buzzbands_employee?
  end

  def update?
    @user.admin? || @user.buzzbands_employee?
  end

  def index?
    @user.admin? || @user.buzzbands_employee?
  end

  def destroy?
    @user.admin? || @user.buzzbands_employee?
  end
end
