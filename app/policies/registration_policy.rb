class RegistrationPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    user.admin? || record.user == user
  end

  def create?
    user.present?
  end

  def destroy?
    user.admin? || record.user == user
  end
end