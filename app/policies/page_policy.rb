class PagePolicy < ApplicationPolicy
  def feed?
    user.present?
  end
end
