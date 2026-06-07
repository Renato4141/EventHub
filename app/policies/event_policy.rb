class EventPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    record.published? || record.finished? || record.ongoing? ||
      record.user == user || user&.admin?
  end

  def create?
    user.present?
  end

  def update?
    user.admin? || record.user == user
  end

  def destroy?
    user.admin? || record.user == user
  end
end