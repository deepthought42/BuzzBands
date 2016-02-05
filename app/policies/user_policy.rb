class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.role == "buzzbands_employee"
        scope.all
      end
    end
  end

  def update?
    @user.admin? || @user.buzzbands_employee?
  end

  def destroy?
    @user.admin? || @user.buzzbands_employee?
  end
end
