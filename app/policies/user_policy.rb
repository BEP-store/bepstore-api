class UserPolicy < ApplicationPolicy
  def find?
    false
  end

  def create?
    true
  end

  def show?
    false
  end

  def current?
    true
  end

  def update?
    record == user
  end

  def permitted_attributes
    [:name, :email, :password]
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
