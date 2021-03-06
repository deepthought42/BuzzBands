class UserPolicy < ApplicationPolicy
  class Scope < Struct.new(:user, :scope)
    def resolve
      if user.hypedrive_employee?
        scope.all
      end
    end

    #def permitted_attributes
    #  if user.hypedrive_employee?
    #    [:title, :body, :tag_list]
    #  else
    #    [:tag_list]
    #  end
    #end
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
