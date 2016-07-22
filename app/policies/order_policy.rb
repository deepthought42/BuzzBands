class OrderPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.role == 'hypedrive_employee'
        scope.all
      elsif user.role == 'admin'
        #get all orders for user
      end
    end
  end

  def show?
    @user.admin? || @user.hypedrive_employee?
  end

  def new?
    @user.admin? || @user.hypedrive_employee?
  end

  def create?
    @user.admin? || @user.hypedrive_employee?
  end

  def update?
    @user.admin? || @user.hypedrive_employee?
  end

  def index?
    @user.admin? || @user.hypedrive_employee?
  end

  def destroy?
    @user.admin? || @user.hypedrive_employee?
  end

  def previousMonthBandOrders?
    @user.admin? || @user.hypedrive_employee?
  end
end
