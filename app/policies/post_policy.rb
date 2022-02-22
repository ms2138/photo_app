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
end
