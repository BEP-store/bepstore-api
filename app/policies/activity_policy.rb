class ActivityPolicy < ApplicationPolicy
  def index?
    true
  end

  def find?
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
    []
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
