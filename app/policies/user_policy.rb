class UserPolicy < ApplicationPolicy
  def find?
    true
  end

  def create?
    true
  end

  def show?
    true
  end

  def current?
    true
  end

  def update?
    record == user
  end

  def permitted_attributes
    [:name, :bio, :account_id]
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
