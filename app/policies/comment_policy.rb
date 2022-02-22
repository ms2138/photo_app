class CommentPolicy < ApplicationPolicy
  def index?
    user.present?
  end

  def create?
    user.present?
  end

  def new?
    create?
  end

  def destroy?
    user.present? && user == record.user
  end
end