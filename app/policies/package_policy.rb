cclass PackagePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def update?
    user.admin? || @user.buzzbands_employee?
  end

  def create?
    user.user? || @user.buzzbands_employee?
  end

  def destroy?
    @user.admin? || @user.buzzbands_employee?
  end
end
