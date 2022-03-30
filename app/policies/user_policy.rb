class UserPolicy < ApplicationPolicy
  def index?
    user.present?
  end

  def show?
    user.present?
  end

  def destroy?
    user.id == @user.id || @user.admin?
  end

  private

  def user
    record
  end
end
