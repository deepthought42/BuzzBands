class AccountPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.role == 'hypedrive_employee'
        scope.all
      end
    end
  end

  def update?
    @user.admin? || @user.hypedrive_employee?
  end

  def create?
    @user.user? || @user.hypedrive_employee?
  end

  def destroy?
    @user.admin? || @user.hypedrive_employee?
  end
end
