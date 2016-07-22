class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.role == "hypedrive_employee"
        scope.all
      end
    end
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
