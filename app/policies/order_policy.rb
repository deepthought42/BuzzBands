class OrderPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.role == 'buzzbands_employee'
        scope.all
      elsif user.role == 'admin'
        #get all orders for user
      end
    end
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

  def previousMonthBandOrders?
    @user.admin? || @user.buzzbands_employee?
  end
end
