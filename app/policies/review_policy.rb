class ReviewPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def create?
    user.present? &&
      record.event.finished? &&
      record.event.registrations.exists?(user: user, status: :confirmed)
  end

  def destroy?
    user.admin? || record.user == user
  end
end