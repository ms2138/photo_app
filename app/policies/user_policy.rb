class UserPolicy < ApplicationPolicy
  def index?
    user.present?
  end

  def show?
    user.present?
  end

  def edit?
    user.id == @user.id
  end

  def destroy?
    user.id == @user.id || @user.admin?
  end

  def followers?
    user.present?
  end

  def following?
    user.present?
  end

  private

  def user
    record
  end
end
