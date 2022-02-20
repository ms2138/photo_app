class UserPolicy < ApplicationPolicy
  def show?
    user.present?
  end

  def destroy?
    user.id == @user.id
  end
end
