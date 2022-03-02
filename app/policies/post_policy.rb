class PostPolicy < ApplicationPolicy
  def index?
    user.present?
  end

  def show?
    user.present?
  end

  def create?
    user.present? && user == record.user
  end

  def new?
    create?
  end

  def liked?
    user.present? && user.id == @user.id
  end

  def like?
    user.present?
  end

  def unlike?
    user.present?
  end
end
