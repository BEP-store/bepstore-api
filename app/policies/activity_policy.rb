class ActivityPolicy < ApplicationPolicy
  def index?
    true
  end

  def filter?
    true
  end

  def show?
    true
  end

  def create?
    true
  end

  def update?
    record.user == user
  end

  def destroy?
    record.user == user
  end

  def permitted_attributes
    [:id, :type, :created_at, :engine]
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
